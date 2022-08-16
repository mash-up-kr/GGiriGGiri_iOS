//
//  MyBoxViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift

protocol MyBoxViewModelProtocol {
    var applyListUpdated: BehaviorRelay<[GifticonCard]?> { get }
    var registerListUpdated: BehaviorRelay<[GifticonCard]?> { get }
    
    var push: ((UIViewController) -> ())? { get set }
    
    var dataSource: MyBoxCollectionViewDataSource { get }
    var delegate: MyBoxCollectionViewDelegate { get }
}

final class MyBoxViewModel: MyBoxViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let gifticonService: GifticonService
    
    var push: ((UIViewController) -> ())? = nil
    
    var applyListUpdated = BehaviorRelay<[GifticonCard]?>(value: nil)
    var registerListUpdated = BehaviorRelay<[GifticonCard]?>(value: nil)
    
    lazy var dataSource: MyBoxCollectionViewDataSource = {
        let dataSource = MyBoxCollectionViewDataSource()
        dataSource.applyDataSource.resultButtonDelegate = self
        dataSource.applyDelegate.myBoxApplyListCardDelegate = self
        dataSource.registerDelegate.myBoxApplyListCardDelegate = self
        return dataSource
    }()
    let delegate = MyBoxCollectionViewDelegate()
    
    init(network: Networking) {
        self.gifticonService = GifticonService(network: network)
        
        applyHistory()
        registerHistory()
    }
    
    private func applyHistory() {
        gifticonService.applyHistory()
            .subscribe { [weak self] entity in
                guard let applyHistoryModel = entity.data else { return }
                let entity = ApplyHistoryEntity.init(applyHistoryModel)
                self?.dataSource.updateApplyList(entity.gifticonList)
                self?.applyListUpdated.accept(entity.gifticonList)
            } onFailure: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func registerHistory() {
        gifticonService.registerHistory()
            .subscribe { [weak self] entity in
                guard let registerHistoryModel = entity.data else { return }
                let entity = RegisterHistoryEntity.init(registerHistoryModel)
                self?.dataSource.updateRegisterList(entity.gifticonList)
                self?.registerListUpdated.accept(entity.gifticonList)
            } onFailure: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}

extension MyBoxViewModel: MyBoxListCollectionViewButtonDelegate {
    
    func resultButtonTapped(with id: Int, result: DrawStatus) {
        let resultViewModel = ResultViewModel(gifticonId: id, type: result.gifticonResult, network: Network())
        
        if result == .win {
            resultViewModel.type = .win
        } else if result == .lose {
            resultViewModel.type = .lose
        }
        
        let resultViewController = ResultViewController(resultViewModel)
        resultViewController.modalPresentationStyle = .fullScreen
        push?(resultViewController)
    }
}

extension MyBoxViewModel: MyBoxListCardDelegate {
    
    func cellTapped(type: MyBox, id: Int, drawStatus: DrawStatus) {
        if type == .applied {
            
            // 진행 중
            if drawStatus == .progress {
                let applyViewModel = ApplyViewModel(gifticonId: id, network: Network())
                let applyViewController = ApplyViewController(applyViewModel)
                applyViewController.modalPresentationStyle = .fullScreen
                push?(applyViewController)
                return
            }
            
            // 응모 결과 나왔을 경우
            let resultViewModel = ResultViewModel(gifticonId: id, type: drawStatus.gifticonResult, network: Network())
            
            let resultViewController = ResultViewController(resultViewModel)
            resultViewController.modalPresentationStyle = .fullScreen
            push?(resultViewController)
            return
        }
        
    }
}

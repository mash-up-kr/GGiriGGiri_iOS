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
        dataSource.applyDelegate.collectionViewCellDelegate = self
        dataSource.registerDelegate.collectionViewCellDelegate = self
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
            .debug()
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
            .debug()
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

extension MyBoxViewModel: MyBoxListCollectionViewCellDelegate {
    func cellTapped(type: MyBox, with index: Int) {
        let resultViewModel = ResultViewModel()
        resultViewModel.type = .win
        let resultViewController = ResultViewController(resultViewModel)
        resultViewController.modalPresentationStyle = .fullScreen
        push?(resultViewController)
    }
}

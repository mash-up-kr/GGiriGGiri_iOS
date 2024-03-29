//
//  SplashViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift

protocol SplashViewModelProtocol {
    var deadlineDataCountUpdated: PublishRelay<Int> { get }
}

final class SplashViewModel: SplashViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private let gifticonService: GifticonService
    
    init(network: Networking) {
        self.gifticonService = GifticonService(network: network)
        
        deadlineInfo()
    }
    
    var deadlineDataCountUpdated = PublishRelay<Int>()
    
    private func deadlineInfo() {
        gifticonService.deadline(.init(orderBy: .deadLine, category: .all))
            .subscribe { [weak self] responseModel in
                if responseModel.code == "S001" {
                    // 성공
                    guard let responseModel = responseModel.data else {
                        return
                    }
                    let entity = GifticonEntity.init(responseModel)
                    self?.deadlineDataCountUpdated.accept(entity.gifticonList.count)
                    self?.changeRootViewController(deadlineData: entity.gifticonList.count)
                } else {
                    // 서버의 API 실패 처리 (S001이외의 에러)
                    self?.deadlineDataCountUpdated.accept(.zero)
                    self?.changeRootViewController(deadlineData: .zero)
                }
            } onFailure: { [weak self] error in
                // http 네트워크 에러
                self?.deadlineDataCountUpdated.accept(.zero)
                self?.changeRootViewController(deadlineData: .zero)
            }.disposed(by: disposeBag)
    }
    
    private func changeRootViewController(deadlineData: Int) {
        let rootViewController = MainViewController(
            MainViewModel(
                network: Network(),
                repository: CategoryRepository(CategoryService(network: Network())),
                OCRRepository: OCRRepository(OCRService(network: Network()))
            ))
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        UIApplication.shared.windows.first?.replaceRootViewController(navigationController, animated: true, completion: nil)
    }
}

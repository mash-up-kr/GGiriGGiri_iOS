//
//  SplashViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxRelay
import RxSwift
import UIKit

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
                guard let responseModel = responseModel.data else {
                    return
                }
                let entity = GifticonEntity.init(responseModel)
                self?.deadlineDataCountUpdated.accept(entity.gifticonList.count)
                
                self?.changeRootViewController(deadlineData: entity.gifticonList.count)
            } onFailure: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func changeRootViewController(deadlineData: Int) {
        
        var isDeadlineDataExist = true
        
        if deadlineData == 0 {
            isDeadlineDataExist = false
        }
        
        let rootViewController = MainViewController(
            MainViewModel(
                network: Network(),
                repository: CategoryRepository(CategoryService(network: Network())),
                OCRRepository: OCRRepository(OCRService(network: Network())),
                deadlineDataExist: isDeadlineDataExist
            ))
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        UIApplication.shared.windows.first?.replaceRootViewController(navigationController, animated: true, completion: nil)
    }
}

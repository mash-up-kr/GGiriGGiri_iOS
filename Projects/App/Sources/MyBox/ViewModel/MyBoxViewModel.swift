//
//  MyBoxViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxRelay
import RxSwift

protocol MyBoxViewModelProtocol {
    var gifticonList: BehaviorRelay<[GifticonCard]?> { get }
}

final class MyBoxViewModel: MyBoxViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let gifticonService: GifticonService
    var gifticonList = BehaviorRelay<[GifticonCard]?>(value: nil)
    
    init(network: Networking) {
        self.gifticonService = GifticonService(network: network)
        
        applyHistory()
    }
    
    private func applyHistory() {
        gifticonService.applyHistory()
            .debug()
            .subscribe { [weak self] entity in
                guard let applyHistoryModel = entity.data else { return }
                let entity = ApplyHistoryEntity.init(applyHistoryModel)
                self?.gifticonList.accept(entity.gifticonList)
            } onFailure: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}

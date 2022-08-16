//
//  ResultViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxRelay
import RxSwift

protocol ResultViewModelProtocol {
    var type: GifticonResult { get }
    var couponInfo: PublishRelay<CouponInfo?> { get }
}

final class ResultViewModel: ResultViewModelProtocol {
    
    var type: GifticonResult
    let couponInfo = PublishRelay<CouponInfo?>()
    
    private let disposeBag = DisposeBag()
    private let gifticonId: Int
    private let gifticonService: GifticonService
    
    init(
        gifticonId: Int,
        type: GifticonResult,
        network: Networking
    ) {
        self.gifticonId = gifticonId
        self.type = type
        self.gifticonService = GifticonService(network: network)
        
        drawResult()
    }
    
    private func drawResult() {
        gifticonService.drawResult(self.gifticonId)
            .debug()
            .subscribe(onSuccess: { [weak self] responseModel in
                guard let responseData = responseModel.data else {
                    return
                }
                self?.couponInfo.accept(responseData.couponInfo)
            })
            .disposed(by: disposeBag)
    }
}

//
//  ApplyViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxRelay
import RxSwift

protocol ApplyViewModelProtocol {
    var showToastView: PublishRelay<(Bool, String?, Error?)> { get }
    var detailData: BehaviorRelay<CouponDatum?> { get }

    func applyButtonTapped()
}

final class ApplyViewModel: ApplyViewModelProtocol {
    let detailData = BehaviorRelay<CouponDatum?>(value: nil)
    let showToastView = PublishRelay<(Bool, String?, Error?)>()
    private let gifticonService: GifticonService
    private let disposeBag = DisposeBag()

    private let gifticonId: Int
    
    init(gifticonId: Int, network: Networking) {
        self.gifticonId = gifticonId
        self.gifticonService = GifticonService(network: network)
        detailInfo()
    }

    private func detailInfo() {
        gifticonService.detail(self.gifticonId)
            .subscribe(onSuccess: { [weak self] responseModel in
                guard let responseData = responseModel.data else { return
                }
                self?.detailData.accept(responseData)
            })
            .disposed(by: disposeBag)
    }

    func applyButtonTapped() {
        gifticonService.apply(self.gifticonId)
            .subscribe { [weak self] applyResponse in
                if applyResponse.code == "S001" {
                    self?.showToastView.accept((true, applyResponse.message, nil))
                } else {
                    self?.showToastView.accept((false, applyResponse.message, nil))
                }
            } onFailure: { [weak self] applyResponse in
                self?.showToastView.accept((false, nil, applyResponse))
            }
            .disposed(by: disposeBag)
    }
}

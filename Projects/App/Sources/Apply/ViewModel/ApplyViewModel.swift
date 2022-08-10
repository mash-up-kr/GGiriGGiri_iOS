//
//  ApplyViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ApplyViewModelProtocol {
    var showToastView: PublishRelay<Bool> { get }
    var detailData: BehaviorRelay<CouponDatum> { get }

    func applyButtonTapped()
}

final class ApplyViewModel: ApplyViewModelProtocol {
    let detailData = BehaviorRelay<CouponDatum>(value: CouponDatum(sprinkleID: 0, brandName: "dd", merchandiseName: "", category: "", expiredAt: "", participants: 0, sprinkleAt: "", participateIn: nil))
    let showToastView = PublishRelay<Bool>()
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
            }, onFailure: { error in
            })
            .disposed(by: disposeBag)
    }

    func applyButtonTapped() {
        gifticonService.apply(self.gifticonId)
            .subscribe { [weak self] _ in
                self?.showToastView.accept(true)
            } onFailure: { [weak self] _ in
                self?.showToastView.accept(false)
            }
            .disposed(by: disposeBag)
    }
}

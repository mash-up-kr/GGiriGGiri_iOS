//
//  OCRRepository.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift

enum ResponseError: String {
    case size
    case type
    case `default`

    var info: (toastTitle: String, toastDescription: String) {
        switch self {
        case .size:
            return ("이미지 가져오기 실패", "용량이 너무 커요.\n다시 한번 시도해주세요!")
        case .type:
            return ("이미지 가져오기 실패", "등록할 수 없는 이미지 포맷이에요.\n이미지의 포맷(jpg,png 등)을 확인해주세요!")
        case .default:
            return ("", "")
        }
    }
}

protocol OCRRepositoryLogic {
    var sprinkleInformation: BehaviorRelay<(SprinkleInformation?, ResponseError)> { get }
    
    func request(_ image: UIImage)
}

final class OCRRepository: OCRRepositoryLogic {
    private let disposeBag = DisposeBag()
    private let OCRService: OCRServiceLogic
    
    var sprinkleInformation = BehaviorRelay<(SprinkleInformation?, ResponseError)>(value: (nil, .default))
    
    init(_ OCRService: OCRServiceLogic) {
        self.OCRService = OCRService
    }
    
    func request(_ image: UIImage) {
        OCRService.request(OCRRequestModel(image: image))
            .subscribe(onSuccess: { [weak self] in
                switch $0.code {
                case "S001":
                    self?.sprinkleInformation.accept((
                        SprinkleInformation(
                            image: image,
                            brandName: $0.data?.brandName ?? "",
                            productName: $0.data?.productName ?? "",
                            expirationDate: $0.data?.expirationDate.format(.yearMonthDay) ?? ""
                        ), .default
                    ))
                case "C002":
                    self?.sprinkleInformation.accept((
                        SprinkleInformation(
                            image: image
                        ), .default
                    ))
                case "F003":
                    self?.sprinkleInformation.accept((nil, .type))
                default:
                    self?.sprinkleInformation.accept((nil, .size))
                }
            })
            .disposed(by: disposeBag)
    }
}

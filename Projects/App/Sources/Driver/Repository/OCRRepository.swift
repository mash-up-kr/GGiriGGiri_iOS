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

protocol OCRRepositoryLogic {
    var sprinkleInformation: BehaviorRelay<SprinkleInformation?> { get }
    
    func request(_ image: UIImage)
}

final class OCRRepository: OCRRepositoryLogic {
    private let disposeBag = DisposeBag()
    private let OCRService: OCRServiceLogic
    
    var sprinkleInformation = BehaviorRelay<SprinkleInformation?>(value: nil)
    
    init(_ OCRService: OCRServiceLogic) {
        self.OCRService = OCRService
    }
    
    func request(_ image: UIImage) {
        OCRService.request(OCRRequestModel(image: image))
            .subscribe(onSuccess: { [weak self] in
                guard let model = $0.data else {
                    self?.sprinkleInformation.accept(nil)
                    return
                }
                self?.sprinkleInformation.accept(
                    SprinkleInformation(
                        image: image,
                        brandName: model.brandName,
                        productName: model.productName,
                        expirationDate: model.expirationDate.format(.yearMonthDay)
                    )
                )
            })
            .disposed(by: disposeBag)
    }
}

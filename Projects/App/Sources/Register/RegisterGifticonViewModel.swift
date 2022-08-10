//
//  RegisterGifticonViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/05.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift

protocol RegisterGifticonViewModelProtocol {
    var categoryRepository: CategotyRespositoryLogic? { get }
    
    var gifticonImage: UIImage { get }
    var informationValidate: PublishRelay<Bool> { get }
    var toast: PublishRelay<RegisterGifticonViewModel.Toast> { get }
    
    func update(_ type: RegisterGifticonViewModel.Update)
    func requestRegister()
}

final class RegisterGifticonViewModel: RegisterGifticonViewModelProtocol {
    enum Update {
        case category(Int)
        case brandName(String?)
        case productName(String?)
        case expirationDate(String?)
        case deadLineMinute(String?)
    }
    enum Toast {
        case registerSuccess
        case registerFail
    }
    
    var categoryRepository: CategotyRespositoryLogic?
    
    // TODO: Gifticon API 리팩토링 후 제거할것
    private let network: Networking
    private lazy var service = GifticonService(network: network)
    private let disposeBag = DisposeBag()
    
    var gifticonImage: UIImage {
        information.image
    }
    var informationValidate = PublishRelay<Bool>()
    var toast = PublishRelay<Toast>()
    
    private var information: SprinkleInformation
    
    init(network: Networking, categoryRepository: CategotyRespositoryLogic, gifticonImage: UIImage) {
        self.network = network
        self.categoryRepository = categoryRepository
        self.information = SprinkleInformation(image: gifticonImage)
        
        configure()
    }
    
    private func configure() {
        categoryRepository?.fetchCategories()
    }
    
    func update(_ type: Update) {
        switch type {
        case let .category(index):
            guard
                let category = categoryRepository?.categoryEntity.value.expectAll[index].rawValue
            else { return }
            information.category = category
        case let .brandName(name):
            information.brandName = name
        case let .productName(name):
            information.productName = name
        case let .expirationDate(date):
            information.expirationDate = date
        case let .deadLineMinute(minute):
            information.deadLineMinute = minute
        }
        
        checkValidation()
    }
    
    private func checkValidation() {
        informationValidate.accept(information.isValidate())
    }
}

// MARK: - Networkings

extension RegisterGifticonViewModel {
    func requestRegister() {
        service.registerSprinkle(information)
            .subscribe(onSuccess: { [weak self] in
                // TODO: 에러코드별 처리방법 고도화하기
                guard $0.code == "S001" else {
                    self?.toast.accept(.registerFail)
                    return
                }
                self?.toast.accept(.registerSuccess)
            })
            .disposed(by: disposeBag)
    }
}

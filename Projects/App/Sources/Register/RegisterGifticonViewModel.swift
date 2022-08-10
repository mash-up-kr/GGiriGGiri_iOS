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
    var gifticonImage: UIImage { get }
    var categories: BehaviorRelay<[String]> { get }
    var informationValidation: PublishRelay<Bool> { get }
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
        case deadlineMinute(String?)
    }
    enum Toast {
        case registerSuccess
        case registerFail
    }
    private let network: Networking
    private lazy var service = GifticonService(network: network)
    private let disposeBag = DisposeBag()
    
    var gifticonImage: UIImage {
        information.image
    }
    var categories = BehaviorRelay<[String]>(value: [])
    var informationValidation = PublishRelay<Bool>()
    var toast = PublishRelay<Toast>()
    
    private var information: SprinkleInformation
    
    init(network: Networking, gifticonImage: UIImage) {
        self.network = network
        self.information = SprinkleInformation(image: gifticonImage)
        
        fetchCategories()
    }
    
    
    func update(_ type: Update) {
        switch type {
        case let .category(index):
            let category = categories.value[index]
            information.category = category
        case let .brandName(name):
            information.brandName = name
        case let .productName(name):
            information.productName = name
        case let .expirationDate(date):
            information.expirationDate = date
        case let .deadlineMinute(minute):
            information.deadlineMinute = minute
        }
        
        checkValidation()
    }
    
    private func checkValidation() {
        informationValidation.accept(information.isValidate())
    }
}

// MARK: - Networkings

extension RegisterGifticonViewModel {
    func fetchCategories() {
        service.categories()
            .subscribe(onSuccess: { [weak self] in
                guard let cateogires = $0.data else { return }
                self?.categories.accept(cateogires)
            })
            .disposed(by: disposeBag)
    }
    
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

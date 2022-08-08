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
    var gifticonImage: UIImage { get set }
    var categories: BehaviorRelay<[String]> { get }
    var informationValidate: PublishRelay<Bool> { get }
    
    func update(_ type: RegisterGifticonViewModel.Update)
}

final class RegisterGifticonViewModel: RegisterGifticonViewModelProtocol {
    enum Update {
        case category(Int)
        case brandName(String?)
        case productName(String?)
        case expirationDate(String?)
        case deadLineMinute(String?)
    }
    private let network: Networking
    private lazy var service = GifticonService(network: network)
    private let disposeBag = DisposeBag()
    
    var gifticonImage: UIImage
    var categories = BehaviorRelay<[String]>(value: [])
    var informationValidate = PublishRelay<Bool>()
    
    private var information = SprinkleInformation()
    
    init(network: Networking, gifticonImage: UIImage) {
        self.network = network
        self.gifticonImage = gifticonImage
        
        fetchCategories()
    }
    
    func fetchCategories() {
        service.categories()
            .subscribe(onSuccess: { [weak self] in
                guard let cateogires = $0.data else { return }
                self?.categories.accept(cateogires)
            })
            .disposed(by: disposeBag)
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
        case let .deadLineMinute(minute):
            information.deadLineMinute = minute
        }
        
        checkValidation()
    }
    
    private func checkValidation() {
        informationValidate.accept(information.isValidate())
    }
}

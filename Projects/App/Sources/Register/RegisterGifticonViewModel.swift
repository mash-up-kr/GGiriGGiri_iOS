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
}

final class RegisterGifticonViewModel: RegisterGifticonViewModelProtocol {
    private let network: Networking
    private lazy var service = GifticonService(network: network)
    private let disposeBag = DisposeBag()
    
    var gifticonImage: UIImage
    var categories = BehaviorRelay<[String]>(value: [])
    
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
}

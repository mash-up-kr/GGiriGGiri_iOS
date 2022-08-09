//
//  CategoryService.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxSwift

struct CategoryService {
    typealias CategoryListResponse = ResponseData<[CategoryResponseModel]>
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func categories() -> CategoryListResponse {
        network.request(CategoryAPI.categories).map()
    }
}

//
//  GifticonService.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxSwift

struct GifticonService {
    typealias CouponListResponse = Response<[CouponEntity]>
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func list(_ model: GifticonListRequestModel) -> CouponListResponse {
        network.request(GifticonAPI.categoryList(model)).map()
    }
}

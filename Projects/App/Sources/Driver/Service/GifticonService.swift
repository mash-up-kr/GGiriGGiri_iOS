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
    typealias CouponListResponse = ResponseData<[CouponEntity]>
    typealias RegisterSprinkleResponse = Response
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func list(_ model: GifticonListRequestModel) -> CouponListResponse {
        network.request(GifticonAPI.categoryList(model)).map()
    }
    
    func registerSprinkle(_ entity: SprinkleInformation) -> RegisterSprinkleResponse {
        network.request(
            GifticonAPI.registerSprinkle(
                SprinkleRegisterRequestModel(entity)
            )
        ).map()
    }
}

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
    typealias CouponDetailResponse = ResponseData<CouponDatum>
    typealias CouponPostResponse = Response
    typealias CategoryListResponse = ResponseData<[String]>
    typealias RegisterSprinkleResponse = Response
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func list(_ model: GifticonListRequestModel) -> CouponListResponse {
        network.request(GifticonAPI.categoryList(model)).map()
    }

    func detail(_ id: Int) -> CouponDetailResponse {
        network.request(GifticonAPI.sprinkleDetail(id)).map()
    }

    func apply(_ id: Int) -> CouponPostResponse {
        network.request(GifticonAPI.sprinkleApplication(id)).map()
    }
    
    func registerSprinkle(_ entity: SprinkleInformation) -> RegisterSprinkleResponse {
        network.request(
            GifticonAPI.registerSprinkle(
                SprinkleRegisterRequestModel(entity)
            )
        ).map()
    }
}

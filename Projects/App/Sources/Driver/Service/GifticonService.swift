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
    typealias DeadlineResponse = ResponseData<[GifticonResponseModel]>
    typealias CouponListResponse = ResponseData<[CouponEntity]>
    typealias CouponDetailResponse = ResponseData<CouponDatum>
    typealias CouponPostResponse = Response
    typealias CategoryListResponse = ResponseData<[GifticonResponseModel]>
    typealias RegisterSprinkleResponse = Response
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func deadline(_ model: GifticonListRequestModel) -> DeadlineResponse {
        network.request(GifticonAPI.deadline(model)).map()
    }
    
    func categoryList(_ model: GifticonListRequestModel) -> CategoryListResponse {
        network.request(GifticonAPI.categoryList(model)).map()
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

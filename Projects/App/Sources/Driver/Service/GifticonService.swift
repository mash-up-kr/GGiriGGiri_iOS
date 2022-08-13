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
    typealias GifticonListResponse = ResponseData<[GifticonResponseModel]>
    typealias RegisterSprinkleResponse = Response
    typealias ApplyHistoryResponse = ResponseData<[ApplyHistoryResponseModel]>
    typealias RegisterHistoryResponse = ResponseData<[RegisterHistoryResponseModel]>
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    // MARK: MAIN
    func deadline(_ model: GifticonListRequestModel) -> DeadlineResponse {
        network.request(GifticonAPI.deadlineGifticonList(model)).map()
    }
    
    func gifticonList(_ model: GifticonListRequestModel) -> GifticonListResponse {
        network.request(GifticonAPI.categoryGifticonList(model)).map()
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
    
    // MARK: 마이박스 - 응모 / 등록
    func applyHistory() -> ApplyHistoryResponse {
        network.request(GifticonAPI.applyHistory).map()
    }
    
    func registerHistory() -> RegisterHistoryResponse {
        network.request(GifticonAPI.registerHistory).map()
    }
}

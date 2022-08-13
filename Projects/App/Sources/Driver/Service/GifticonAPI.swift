//
//  GifticonAPI.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import Alamofire

enum GifticonAPI {
    /// 카테고리 목록 조회
    case categories
    
    /// 쿠폰 카테고리별 조회 목록
    case categoryGifticonList(GifticonListRequestModel)
    
    /// 쿠폰 마감임박 조회
    case deadlineGifticonList(GifticonListRequestModel)
    
    /// 뿌리기 등록
    case registerSprinkle(SprinkleRegisterRequestModel)
    
    /// 응모하기
    case sprinkleApplication(Int)
    
    /// 쿠폰 상세
    case sprinkleDetail(Int)
    
    /// 내 기프티콘 응모 내역 조회
    case applyHistory
    
    /// 내 기프티콘 등록 내역 조회
    case registerHistory
}

extension GifticonAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .categories:
            return "/api/v1/coupon/category"
        case .categoryGifticonList, .deadlineGifticonList:
            return "/api/v1/sprinkles"
        case .registerSprinkle:
            return "/api/v1/sprinkle"
        case .sprinkleApplication(let id):
            return "/api/v1/sprinkle/\(id)/apply"
        case .sprinkleDetail(let id):
            return "/api/v1/sprinkle-info/\(id)"
        case .applyHistory:
            return "/api/v1/participant/history"
        case .registerHistory:
            return "/api/v1/sprinkle/registration-history"
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .sprinkleApplication, .sprinkleDetail, .categories, .applyHistory, .registerHistory:
            return nil
        case let .categoryGifticonList(model), let .deadlineGifticonList(model):
            return model
        case let .registerSprinkle(model):
            return model
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .categories, .categoryGifticonList, .deadlineGifticonList, .sprinkleApplication, .sprinkleDetail, .applyHistory, .registerHistory:
            return .default
        case .registerSprinkle:
            return .multipartHeader
        }
    }

    var method: HTTPMethod {
        switch self {
        case .categoryGifticonList, .deadlineGifticonList, .sprinkleDetail, .categories, .applyHistory, .registerHistory:
            return .get
        case .sprinkleApplication, .registerSprinkle:
            return .post
        }
    }
}

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
    case categories
    case categoryList(GifticonListRequestModel)
    case registerSprinkle(SprinkleRegisterRequestModel)
    case sprinkleApplication(Int)
    case sprinkleDetail(Int)
}

extension GifticonAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .categories:
            return "/api/v1/coupon/category"
        case .categoryList:
            return "/api/v1/sprinkles"
        case .registerSprinkle:
            return "/api/v1/sprinkle"
        case .sprinkleApplication(let id):
            return "/api/v1/sprinkle/\(id)/apply"
        case .sprinkleDetail(let id):
            return "/api/v1/sprinkle-info/\(id)"
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .sprinkleApplication, .sprinkleDetail, .categories:
            return nil
        case let .categoryList(model):
            return model
        case let .registerSprinkle(model):
            return model
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .categories, .categoryList, .sprinkleApplication, .sprinkleDetail:
            return .default
        case .registerSprinkle:
            return .multipartHeader
        }
    }

    var method: HTTPMethod {
        switch self {
        case .categoryList, .sprinkleDetail, .categories:
            return .get
        case .sprinkleApplication, .registerSprinkle:
            return .post
        }
    }
}

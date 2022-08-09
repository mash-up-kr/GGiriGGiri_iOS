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
            return "/api/v1/sprinkle/\(3)/apply"
        case .sprinkleDetail(let id):
            return "/api/v1/sprinkle-info/\(3)"
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .categories:
            return nil
        case let .categoryList(model):
            return model
        case .sprinkleApplication(_):
            return nil
        case .sprinkleDetail(_):
            return nil
        case let .registerSprinkle(model):
            return model
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .categories, .categoryList:
            return .default
        case .registerSprinkle:
            return .multipartHeader
        case .sprinkleApplication(_):
            return .default
        case .sprinkleDetail(_):
            return .default
        }
    }

    var method: HTTPMethod {
        switch self {
        case .categoryList(_):
            return .get
        case .sprinkleApplication(_):
            return .post
        case .sprinkleDetail(_):
            return .get
        case .categories:
            return .get
        case .registerSprinkle(_):
            return .post
        }
    }
}

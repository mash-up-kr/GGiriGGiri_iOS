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
    case categoryList(GifticonListRequestModel)
    case registerSprinkle(SprinkleRegisterRequestModel)
}

extension GifticonAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .categoryList:
            return "/api/v1/sprinkles"
        case .registerSprinkle:
            return "/api/v1/sprinkle"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .categoryList:
            return .get
        case .registerSprinkle:
            return .post
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case let .categoryList(model):
            return model
        case let .registerSprinkle(model):
            return model
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .categoryList:
            return .default
        case .registerSprinkle:
            return .multipartHeader
        }
    }
}

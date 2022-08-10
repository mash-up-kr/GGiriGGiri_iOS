//
//  GifticonAPI.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum GifticonAPI {
    case categories
    case categoryList(GifticonListRequestModel)
}

extension GifticonAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .categories:
            return "/api/v1/coupon/category"
        case .categoryList:
            return "/api/v1/sprinkles"
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .categories:
            return nil
        case let .categoryList(model):
            return model
        }
    }
}

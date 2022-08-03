//
//  GifticonAPI.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum GifticonAPI {
    case categoryList(GifticonListRquestModel)
}

extension GifticonAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .categoryList:
            return "/api/v1/sprinkles"
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case let .categoryList(model):
            return model
        }
    }
}

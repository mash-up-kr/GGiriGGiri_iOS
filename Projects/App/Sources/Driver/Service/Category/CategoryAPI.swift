//
//  CategoryAPI.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import Alamofire

enum CategoryAPI {
    case categories
}

extension CategoryAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .categories:
            return "/api/v1/coupon/category"
        }
    }
}

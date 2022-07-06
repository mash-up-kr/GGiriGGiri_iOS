//
//  CouponAPI.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

// MARK: SAMPLE

enum CouponAPI {
    case list
}

extension CouponAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .list:
            return "/list"
        }
    }
}


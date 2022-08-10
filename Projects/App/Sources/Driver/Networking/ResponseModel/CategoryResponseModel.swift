//
//  CategoryResponseModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum CategoryResponseModel: String, Decodable, CaseIterable {
    case all = "ALL"
    case cafe = "CAFE"
    case delivery = "DELIVERY"
    case icecream = "ICECREAM"
    case convenienceStore = "CONVENIENCE_STORE"
    case fastFood = "FAST_FOOD"
    case voucher = "VOUCHER"
    case etc = "ETC"
}

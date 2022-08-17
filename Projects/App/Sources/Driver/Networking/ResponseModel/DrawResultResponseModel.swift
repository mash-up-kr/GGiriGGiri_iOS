//
//  DrawResultResponseModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/16.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct DrawResultResponseModel: Decodable {
    let drawStatus: DrawStatus
    let couponInfo: CouponInfo?
}

struct CouponInfo: Decodable {
    let brandName, merchandiseName, expiredAt, category: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case brandName, merchandiseName, expiredAt, category
        case imageURL = "imageUrl"
    }
}

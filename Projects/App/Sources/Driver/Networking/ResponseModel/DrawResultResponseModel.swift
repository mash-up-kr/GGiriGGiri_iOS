//
//  ApplyResultResponseModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/16.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

// MARK: - DataClass
struct DrawResultResponseModel: Decodable {
    let drawStatus: String
    let couponInfo: CouponInfo
}

// MARK: - CouponInfo
struct CouponInfo: Decodable {
    let brandName, merchandiseName, expiredAt: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case brandName, merchandiseName, expiredAt
        case imageURL = "imageUrl"
    }
}

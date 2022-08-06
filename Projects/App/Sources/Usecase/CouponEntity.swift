//
//  CouponEntity.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct CouponEntity: Decodable {
    let code, message: String
    let data: [CouponDatum]
}

struct CouponDatum: Codable {
    let sprinkleID: Int
    let brandName, merchandiseName, category, expiredAt: String
    let participants: Int
    let sprinkleAt: String
    let participateIn: Bool

    enum CodingKeys: String, CodingKey {
        case sprinkleID = "sprinkleId"
        case brandName, merchandiseName, category, expiredAt, participants, sprinkleAt, participateIn
    }
}

//
//  CouponEntity.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import DesignSystem

struct CouponEntity: Decodable {
    let code, message: String
    let data: [CouponDatum]
}

struct CouponDatum: Decodable {
    let sprinkleID: Int
    let brandName, merchandiseName, category, expiredAt: String
    let participants: Int
    let sprinkleAt: String
    let participateIn: Bool?

    enum CodingKeys: String, CodingKey {
        case sprinkleID = "sprinkleId"
        case brandName, merchandiseName, category, expiredAt, participants, sprinkleAt, participateIn
    }

    var imageName: DDIPAsset.name {
        switch category {
        case "CAFE":
            return .iconCafedesert
        case "DELIVERY":
            return .iconChicken
        case "ICECREAM":
            return .iconIcecream
        case "CONVENIENCE_STORE":
            return .iconDrugStore
        case "FAST_FOOD":
            return .iconFastfood
        case "VOUCHER":
            return .iconCoupon
        case "ETC":
            return .iconGuitar
        default:
            return .iconLogoCharacter
        }
    }

}

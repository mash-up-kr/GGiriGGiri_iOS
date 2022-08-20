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
        case "카페/디저트":
            return .gifCafedesert
        case "치킨/배달음식":
            return .gifChicken
        case "아이스크림":
            return .gifIcecream
        case "편의점":
            return .gifDrugstore
        case "패스트푸드":
            return .gifFastfood
        case "금액권":
            return .gifCoupon
        case "기타":
            return .gifGuitar
        default:
            return .gifGuitar
        }
    }

}

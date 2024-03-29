//
//  Category.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/01.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import DesignSystem

enum Category: String, CaseIterable {
    case all = "ALL"
    case cafe = "CAFE"
    case delivery = "DELIVERY"
    case icecream = "ICECREAM"
    case convenienceStore = "CONVENIENCE_STORE"
    case fastfood = "FAST_FOOD"
    case voucher = "VOUCHER"
    case etc = "ETC"
    
    var description: String {
        switch self {
        case .all: return "전체"
        case .cafe: return "카페/디저트"
        case .delivery: return "배달음식"
        case .icecream: return "아이스크림"
        case .convenienceStore: return "편의점"
        case .fastfood: return "패스트푸드"
        case .voucher: return "금액권"
        case .etc: return "기타"
        }
    }
    
    var assetName: DDIPAsset.name {
        switch self {
        case .all: return .iconLogoCharacter
        case .cafe: return .iconCafedesert
        case .delivery: return .iconChicken
        case .icecream: return .iconIcecream
        case .convenienceStore: return .iconDrugStore
        case .fastfood: return .iconFastfood
        case .voucher: return .iconCoupon
        case .etc: return .iconGuitar
        }
    }
    
    var gifName: DDIPAsset.name {
        switch self {
        case .cafe:
            return .gifCafedesert
        case .delivery:
            return .gifChicken
        case .icecream:
            return .gifIcecream
        case .convenienceStore:
            return .gifDrugstore
        case .fastfood:
            return .gifFastfood
        case .voucher:
            return .gifCoupon
        case .etc:
            return .gifGuitar
        case .all:
            return .gifGuitar
        }
    }
}

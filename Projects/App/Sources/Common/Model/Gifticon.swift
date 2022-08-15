//
//  Gifticon.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import DesignSystem

/// 순수 기프티콘 정보
struct Gifticon {
    let id: Int
    let brand: String
    let name: String
    let expirationDate: String
    let category: Category
    
    var rotateImageName: DDIPAsset.name {
        switch category {
        case .all:
            return .iconRotateLogoCharacter
        case .cafe:
            return .iconRotateCafedesert
        case .delivery:
            return .iconRotateChicken
        case .icecream:
            return .iconRotateIcecream
        case .convenienceStore:
            return .iconRotateDrugStore
        case .fastfood:
            return .iconRotateFastfood
        case .voucher:
            return .iconRotateCoupon
        case .etc:
            return .iconRotateGuitar
        }
    }

    var standardImageName: DDIPAsset.name {
        switch category {
        case .all:
            return .iconLogoCharacter
        case .cafe:
            return .iconCafedesert
        case .delivery:
            return .iconChicken
        case .icecream:
            return .iconIcecream
        case .convenienceStore:
            return .iconDrugStore
        case .fastfood:
            return .iconFastfood
        case .voucher:
            return .iconCoupon
        case .etc:
            return .iconGuitar
        }
    }
}

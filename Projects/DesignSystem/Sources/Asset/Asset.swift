//
//  Asset.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/19.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public enum DDIPAsset {
    /// 에셋의 이름
    /// - 에셋 추가시 case와 case 에 따른 description을 추가해야합니다.
    public enum name: CustomStringConvertible {
        case iconAngelBracket24
        case iconArrowRight24
        case iconCrossX24
        case iconMyBox24
        case iconCrossFill48
        case iconAlarmNoNotice28
        case iconAlarmNotice28
        case iconEdit24
        case iconPersonEmpty10
        case iconTrashcan24

        case iconCafedesert
        case iconRotateCafedesert
        case iconRotateCafedesertEmpty
        
        case iconChicken
        case iconRotateChicken
        case iconRotateChickenEmpty
        
        case iconCoupon
        case iconRotateCoupon
        case iconRotateCouponEmpty
        
        case iconDrugStore
        case iconRotateDrugStore
        case iconRotateDrugStoreEmpty
        
        case iconFastfood
        case iconRotateFastfood
        case iconRotateFastfoodEmpty
        
        case iconGuitar
        case iconRotateGuitar
        case iconRotateGuitarEmpty
        
        case iconIcecream
        case iconRotateIcecream
        case iconRotateIcecreamEmpty
        
        case iconLogoCharacter
        case iconRotateLogoCharacter
        case iconRotateLogoCharacterEmpty
        
        case chatBubble
        
        case iconLose
        
        case logoMain
        
        case gifCafedesert
        case gifChicken
        case gifCoupon
        case gifDrugstore
        case gifFastfood
        case gifGuitar
        case gifIcecream
        
        public var description: String {
            switch self {
            case .iconAngelBracket24:
                return "icon_angleBracket24"
            case .iconArrowRight24:
                return "icon_arrowRight24"
            case .iconCrossX24:
                return "icon_crossX24"
            case .iconMyBox24:
                return "icon_myBox24"
            case .iconCrossFill48:
                return "icon_cross_fill48"
            case .iconAlarmNoNotice28:
                return "icon_alarm_nonotice28"
            case .iconAlarmNotice28:
                return "icon_alarm_notice28"
            case .iconEdit24:
                return "icon_edit24"
            case .iconPersonEmpty10:
                return "icon_person_empty10"
            case .iconTrashcan24:
                return "icon_trashcan24"
            case .iconCafedesert:
                return "icon_cafedesert"
            case .iconRotateCafedesert:
                return "icon_rotate_cafedesert"
            case .iconRotateCafedesertEmpty:
                return "icon_rotate_cafedesert_empty"
            case .iconChicken:
                return "icon_chicken"
            case .iconRotateChicken:
                return "icon_rotate_chicken"
            case .iconRotateChickenEmpty:
                return "icon_rotate_chicken_empty"
            case .iconCoupon:
                return "icon_coupon"
            case .iconRotateCoupon:
                return "icon_rotate_coupon"
            case .iconRotateCouponEmpty:
                return "icon_rotate_coupon_empty"
            case .iconDrugStore:
                return "icon_drugstore"
            case .iconRotateDrugStore:
                return "icon_rotate_drugstore"
            case .iconRotateDrugStoreEmpty:
                return "icon_rotate_drugstore_empty"
            case .iconFastfood:
                return "icon_fastfood"
            case .iconRotateFastfood:
                return "icon_rotate_fastfood"
            case .iconRotateFastfoodEmpty:
                return "icon_rotate_fastfood_empty"
            case .iconGuitar:
                return "icon_guitar"
            case .iconRotateGuitar:
                return "icon_rotate_guitar"
            case .iconRotateGuitarEmpty:
                return "icon_rotate_guitar_empty"
            case .iconIcecream:
                return "icon_icecream"
            case .iconRotateIcecream:
                return "icon_rotate_icecream"
            case .iconRotateIcecreamEmpty:
                return "icon_rotate_icecream_empty"
            case .iconLogoCharacter:
                return "icon_logocharacter"
            case .iconRotateLogoCharacter:
                return "icon_rotate_logocharacter"
            case .iconRotateLogoCharacterEmpty:
                return "icon_rotate_logocharacter_empty"
            case .chatBubble:
                return "chatBubble"
            case .iconLose:
                return "icon_lose"
            case .logoMain:
                return "logo_main"
            case .gifCafedesert:
                return "gif_cafedessert"
            case .gifChicken:
                return "gif_chicken"
            case .gifCoupon:
                return "gif_coupon"
            case .gifDrugstore:
                return "gif_drugstore"
            case .gifFastfood:
                return "gif_fastfood"
            case .gifGuitar:
                return "gif_guitar"
            case .gifIcecream:
                return "gif_icecream"
            }
        }
    }
}

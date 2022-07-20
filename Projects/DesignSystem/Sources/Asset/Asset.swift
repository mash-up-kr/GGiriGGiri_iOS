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
            }
        }
    }
}

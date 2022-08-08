//
//  Color.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

public enum DDIPColor {
    case neutralBlack
    case neutralWhite
    case neutralGray500
    case neutralGray400
    case neutralGray300
    case neutralGray200
    case neutralGray100
    
    case primaryYellow
    
    case secondaryBlue
    case secondarySkyblue200
    case secondarySkyblue100
    case secondaryYellow
    
    case dangerRaspberry
    
    /// 컬러를 불러오기 위한 name space
    public var name: String {
        switch self {
        case .neutralBlack: return "NeturalBlack"
        case .neutralWhite: return "NeturalWhite"
        case .neutralGray500: return "NeturalGray500"
        case .neutralGray400: return "NeturalGray400"
        case .neutralGray300: return "NeturalGray300"
        case .neutralGray200: return "NeturalGray200"
        case .neutralGray100: return "NeturalGray100"
        case .primaryYellow: return "PrimaryYellow"
        case .secondaryBlue: return "SecondaryBlue"
        case .secondarySkyblue200: return "SecondarySkyblue200"
        case .secondarySkyblue100: return "SecondarySkyblue100"
        case .secondaryYellow: return "SecondaryYellow"
        case .dangerRaspberry: return "DangerRaspberry"
        }
    }
}

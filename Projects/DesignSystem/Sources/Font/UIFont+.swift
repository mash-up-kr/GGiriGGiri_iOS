//
//  UIFont+.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIFont {
    public class func designSystem(_ name: DDIPFont.Name, family: DDIPFont.Family, size: DDIPFont.Size) -> UIFont {
        switch name {
        case .chakrapeth:
            return chakraPetch(family: family, size: size)
        case .pretendard:
            return pretendard(family: family, size: size)
        }
    }

    /// ChekraPetch 폰트
    /// - Parameters:
    ///   - family: 사용할 패밀리 [default  bold]
    ///   - size: 적용될 사이즈 [default 20]
    private class func chakraPetch(family: DDIPFont.Family = .bold, size: DDIPFont.Size = ._20) -> UIFont {
        let font = DDIPFont.DDIPFonts(name: .chakrapeth, family: family)
        return _font(name: font.name, size: size.rawValue)
    }
    
    /// Pretendard 폰트
    /// - Parameters:
    ///   - family: 사용할 패밀리
    ///   - size: 적용될 사이즈
    private class func pretendard(family: DDIPFont.Family = .regular, size: DDIPFont.Size) -> UIFont {
        let font = DDIPFont.DDIPFonts(name: .pretendard, family: family)
        return _font(name: font.name, size: size.rawValue)
    }
    
    private class func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

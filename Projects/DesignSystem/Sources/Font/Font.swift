//
//  Font.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public enum DDIPFont {
    /// 폰트의 이름
    public enum Name: String {
        case pretendard = "Pretendard"
        case chakrapeth = "ChakraPetch"
    }
    
    /// 폰트에 적용될 패밀리
    public enum Family: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
    }
    
    /// 폰트 파일의 확장자
    public enum Extension: String {
        case ttf
        case otf
    }
    
    /// 폰트 사이즈
    public enum Size: CGFloat {
        case _10 = 10
        case _12 = 12
        case _14 = 14
        case _16 = 16
        case _18 = 18
        case _20 = 20
        case _28 = 28
    }
    
    /// 폰트의 속성(이름, 패밀리, 확장자)
    public struct DDIPFonts {
        private let _name: Name
        private let _family: Family
        private let _extension: Extension
        
        init(name: Name, family: Family, extensions: Extension = .ttf) {
            _name = name
            _family = family
            _extension = extensions
        }
        
        var name: String {
            "\(_name.rawValue)-\(_family.rawValue)"
        }
        
        var `extension`: String {
            _extension.rawValue
        }
    }
    
    /// DesignSystem의 폰트 파일들을 project에 적용. 앱 초기화 시 1회만 호출되면 됨.
    public static func registerFonts() {
        DDIPFont.fonts.forEach {
            registerFont(fontName: $0.name, fontExtension: $0.extension)
        }
    }
}

// MARK: - Private Exetnsion

extension DDIPFont {
    /// 앱에서 사용될 폰트들
    private static var fonts: [DDIPFonts] {
        [
            DDIPFonts(name: .pretendard, family: .regular),
            DDIPFonts(name: .pretendard, family: .medium),
            DDIPFonts(name: .pretendard, family: .bold),
            DDIPFonts(name: .chakrapeth, family: .bold)
        ]
    }
    
    /// 폰트 파일 등록
    /// - Parameters:
    ///   - bundle: 등록할 폰트 파일이 존재하는 Bundle
    ///   - fontName: 등록할 폰트 파일의 이름
    ///   - fontExtension: 등록할 폰트 파일의 확장자
    private static func registerFont(fontName: String, fontExtension: String) {
        guard let fontURL = DesignSystem.Constant.bundle?.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            debugPrint("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
            return
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}

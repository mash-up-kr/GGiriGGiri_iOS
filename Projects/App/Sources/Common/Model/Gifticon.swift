//
//  Gifticon.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

/// 순수 기프티콘 정보
struct Gifticon {
    let brand: String
    let name: String
    let expirationDate: String
    let imageUrl: String
    
    var url: URL {
        URL(string: imageUrl)!
    }
}

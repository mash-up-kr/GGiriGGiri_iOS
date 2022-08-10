//
//  OCRResponseModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct OCRResponseModel: Decodable {
    let brandName: String
    let productName: String
    let expirationDate: String
    
    enum CodingKeys: String, CodingKey {
        case brandName
        case productName = "merchandiseName"
        case expirationDate = "expiredAt"
    }
}

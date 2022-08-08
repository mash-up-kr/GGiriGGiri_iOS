//
//  SprinkleInformation.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

struct SprinkleInformation {
    var category: String?
    var brandName: String?
    var productName: String?
    var expirationDate: String?
    var deadLineMinute: String?
    
    func isValidate() -> Bool {
        if
            let category = category, category.isEmpty == false,
            let brandName = brandName, brandName.isEmpty == false,
            let productName = productName, productName.isEmpty == false,
            let expirationDate = expirationDate, expirationDate.isEmpty == false,
            let deadLineMinute = deadLineMinute, deadLineMinute.isEmpty == false
        {
            return true
        }
        
        return false
    }
}

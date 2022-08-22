//
//  SprinkleInformation.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

struct SprinkleInformation {
    let image: UIImage
    var category: String?
    var brandName: String?
    var productName: String?
    var expirationDate: String?
    var deadlineMinute: String?
    
    init(image: UIImage) {
        self.image = image
    }
    
    init(
        image: UIImage,
        brandName: String,
        productName: String,
        expirationDate: String
    ) {
        self.image = image
        self.brandName = brandName
        self.productName = productName
        self.expirationDate = expirationDate
    }

    mutating func requestable() -> SprinkleInformation {
        self.expirationDate = expirationDate?.inputDateString()

        return self
    }
    
    func isValidate() -> Bool {
        if
            let category = category, category.isEmpty == false,
            let brandName = brandName, brandName.isEmpty == false,
            let productName = productName, productName.isEmpty == false,
            let expirationDate = expirationDate, expirationDate.isEmpty == false,
            let deadlineMinute = deadlineMinute, deadlineMinute.isEmpty == false
        {
            return true
        }
        
        return false
    }
    
    func intDeadLineMinute() -> Int {
        if let deadlineMinute = deadlineMinute, deadlineMinute.isEmpty == false {
            // TODO: 분, 시간 -> 분으로 변경하는 로직 추가하기
            return 30
        }
        
        return .zero
    }
}

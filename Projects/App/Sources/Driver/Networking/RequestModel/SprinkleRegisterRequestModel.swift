//
//  SprinkleRegisterRequestModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct SprinkleRegisterRequestModel: Encodable {
    struct Information: Encodable {
        let category: String
        let brandName: String
        let merchandiseName: String
        let couponExpiredTime: String
        let deadlineMinutes: Int
        
        init(_ entity: SprinkleInformation) {
            self.category = entity.category ?? ""
            self.brandName = entity.brandName ?? ""
            self.merchandiseName = entity.productName ?? ""
            self.couponExpiredTime = entity.expirationDate ?? ""
            self.deadlineMinutes = entity.intDeadLineMinute()
        }
    }
    
    let image: Data
    let eventInfo: Information
    
    init(_ entity: SprinkleInformation) {
        self.image = entity.image.pngData() ?? Data()
        eventInfo = Information(entity)
    }
}

//
//  RegisterHistoryEntity.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/11.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct RegisterHistoryEntity {
    var gifticonList: [GifticonCard] = []
    
    init(_ responseModel: [RegisterHistoryResponseModel] = []) {
        gifticonList = responseModel.compactMap({ model in
            GifticonCard(sprinkleTime: "",
                         gifticonInfo: Gifticon(
                            id: model.sprinkleID,
                            brand: model.brandName,
                            name: model.merchandiseName,
                            expirationDate: model.expiredAt,
                            category: Category(rawValue: model.category) ?? .all),
                         numberOfParticipants: model.participants,
                         isParticipating: false,
                         deliveryDate: model.deliveryDate,
                         sprinkledStatus: SprinkledStatus(rawValue: model.sprinkledStatus))
        })
    }
}

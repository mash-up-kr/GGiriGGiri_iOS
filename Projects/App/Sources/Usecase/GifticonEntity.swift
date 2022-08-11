//
//  GifticonEntity.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct GifticonEntity {
    var gifticonList: [GifticonCard] = []
    
    init(_ responseModel: [GifticonResponseModel] = []) {
        gifticonList = responseModel.compactMap({ model in
            GifticonCard(
                sprinkleTime: model.sprinkleAt,
                gifticonInfo: Gifticon(
                    id: model.sprinkleID,
                    brand: model.brandName,
                    name: model.merchandiseName,
                    expirationDate: model.expiredAt,
                    category: Category(rawValue: model.category) ?? .all),
                numberOfParticipants: model.participants,
                isParticipating: model.participateIn)
        })
    }
}

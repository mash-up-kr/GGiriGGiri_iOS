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
            // 마감 시간이 지난 경우 리스트에 노출되지 않도록 방어
            guard model.sprinkleAt.fullStringDate().compare(Date()) != .orderedAscending else { return nil }
            return GifticonCard(
                sprinkleTime: model.sprinkleAt,
                gifticonInfo: Gifticon(
                    id: model.sprinkleID,
                    brand: model.brandName,
                    name: model.merchandiseName,
                    expirationDate: model.expiredAt,
                    category: Category(rawValue: model.category) ?? .all),
                numberOfParticipants: model.participants,
                isParticipating: model.participateIn
            )
        })
    }
}

//
//  GifticonResponseModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/11.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct GifticonResponseModel: Decodable {
    let sprinkleID: Int
    let brandName, merchandiseName, category, expiredAt: String
    let participants: Int
    let sprinkleAt: String
    let participateIn: Bool

    enum CodingKeys: String, CodingKey {
        case sprinkleID = "sprinkleId"
        case brandName, merchandiseName, category, expiredAt, participants, sprinkleAt, participateIn
    }
}

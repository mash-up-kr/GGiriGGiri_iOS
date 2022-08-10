//
//  RegisterHistoryResponseModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/11.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct RegisterHistoryResponseModel: Decodable {
    let sprinkleID: Int
    let brandName, merchandiseName, expiredAt, category: String
    let participants: Int
    let deliveryDate: String
    let sprinkledStatus: String

    enum CodingKeys: String, CodingKey {
        case sprinkleID = "sprinkleId"
        case brandName, merchandiseName, expiredAt, category, participants, deliveryDate, sprinkledStatus
    }
}

enum SprinkledStatus: String, Codable {
    case finish = "FINISH"
    case noParticipants = "NO_PARTICIPANTS"
    case progress = "PROGRESS"
}

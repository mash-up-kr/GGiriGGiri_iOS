//
//  ApplyHistoryResponseModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/11.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct ApplyHistoryResponseModel: Decodable {
    let participantID, sprinkleID: Int
    let brandName, merchandiseName, expiredAt, category: String
    let participants: Int
    let participateDate: String
    let isChecked: Bool
    let drawStatus: DrawStatus

    enum CodingKeys: String, CodingKey {
        case participantID = "participantId"
        case sprinkleID = "sprinkleId"
        case brandName, merchandiseName, expiredAt, category, participants, participateDate, isChecked, drawStatus
    }
}

enum DrawStatus: String, Codable {
    case lose = "LOSE"
    case progress = "PROGRESS"
    case win = "WIN"
}

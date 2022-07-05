//
//  GifticonCard.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

/// 기프티콘 응모에 사용되는 기프티콘 정보들
struct GifticonCard {
    let remainingTime: String
    let gifticonInfo: Gifticon
    let numberOfParticipants: Int
    let isParticipating: Bool
}

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
    /// 뿌릴 시간
    let sprinkleTime: String
    /// 기프티콘 세부 정보
    let gifticonInfo: Gifticon
    /// 참가자 수
    let numberOfParticipants: Int
    /// 참여 중 여부
    let isParticipating: Bool
}

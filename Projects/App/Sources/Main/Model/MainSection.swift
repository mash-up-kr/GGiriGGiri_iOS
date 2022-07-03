//
//  MainSection.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum MainSection: CaseIterable {
    static var allCases: [MainSection] {
        return [.deadLine([GifticonListCardItem(remainingTime: "",
                                                gifticonInfo: Gifticon(brand: "", name: "", expirationDate: "", imageUrl: ""),
                                                numberOfParticipants: 0,
                                                isParticipating: true)]),
                .category(CategoryList.allCases)]
    }
    
    case deadLine([GifticonListCardItem])
    case category([CategoryList])
}

extension MainSection {
    var headerTitle: String {
        switch self {
        case .deadLine:
            return "🔥 마감 임박 10분 전! 혹시 내가 될 수 있잖아"
        case .category:
            return "👀 무료이니 응모하세요!"
        }
    }
}

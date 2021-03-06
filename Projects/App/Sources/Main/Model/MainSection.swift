//
//  MainSection.swift
//  GGiriGGiri
//
//  Created by μμν¬ on 2022/06/25.
//  Copyright Β© 2022 dvHuni. All rights reserved.
//

import Foundation

enum MainSection: CaseIterable {
    static var allCases: [MainSection] {
        return [.deadLine([GifticonCard(remainingTime: "",
                                                gifticonInfo: Gifticon(brand: "", name: "", expirationDate: "", imageUrl: ""),
                                                numberOfParticipants: 0,
                                                isParticipating: true)]),
                .category(Category.allCases),
                .gifticonList([GifticonCard(remainingTime: "",
                                                    gifticonInfo: Gifticon(brand: "", name: "", expirationDate: "", imageUrl: ""),
                                                    numberOfParticipants: 0,
                                                    isParticipating: true)])]
    }
    
    case deadLine([GifticonCard])
    case category([Category])
    case gifticonList([GifticonCard])
}

extension MainSection {
    var headerTitle: String? {
        switch self {
        case .deadLine:
            return "π₯ λ§κ° μλ° 10λΆ μ ! νΉμ λ΄κ° λ  μ μμμ"
        case .category:
            return "π λ¬΄λ£μ΄λ μλͺ¨νμΈμ!"
        case .gifticonList:
            return nil
        }
    }
}

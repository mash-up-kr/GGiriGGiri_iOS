//
//  MockData.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct MockData {
    static let main: [MainSection] = [
        .deadLine([GifticonCard(remainingTime: "123초",
                                        gifticonInfo:
                                            Gifticon(brand: "스타벅스",
                                                     name: "아메리카노",
                                                     expirationDate: "20220626",
                                                     imageUrl: ""),
                                        numberOfParticipants: 5,
                                        isParticipating: false),
                   GifticonCard(remainingTime: "123초",
                                        gifticonInfo:
                                            Gifticon(brand: "스타벅스",
                                                     name: "아메리카노",
                                                     expirationDate: "20220626",
                                                     imageUrl: ""),
                                        numberOfParticipants: 5,
                                        isParticipating: false),
                   GifticonCard(remainingTime: "123초",
                                        gifticonInfo:
                                            Gifticon(brand: "스타벅스",
                                                     name: "아메리카노",
                                                     expirationDate: "20220626",
                                                     imageUrl: ""),
                                        numberOfParticipants: 5,
                                        isParticipating: false)]),
        .category(CategoryList.allCases),
        .gifticonList([GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: ""),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: ""),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: ""),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: ""),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: ""),
                                            numberOfParticipants: 5,
                                            isParticipating: false)])
    ]
}

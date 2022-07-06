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
                                                     imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                        numberOfParticipants: 5,
                                        isParticipating: false),
                   GifticonCard(remainingTime: "123초",
                                        gifticonInfo:
                                            Gifticon(brand: "스타벅스",
                                                     name: "아메리카노",
                                                     expirationDate: "20220626",
                                                     imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                        numberOfParticipants: 5,
                                        isParticipating: false),
                   GifticonCard(remainingTime: "123초",
                                        gifticonInfo:
                                            Gifticon(brand: "스타벅스",
                                                     name: "아메리카노",
                                                     expirationDate: "20220626",
                                                     imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                        numberOfParticipants: 5,
                                        isParticipating: false)]),
        .category(Category.allCases),
        .gifticonList([GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                            numberOfParticipants: 5,
                                            isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                            gifticonInfo:
                                                Gifticon(brand: "스타벅스",
                                                         name: "아메리카노",
                                                         expirationDate: "20220626",
                                                         imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                            numberOfParticipants: 5,
                                            isParticipating: false)])
    ]
}

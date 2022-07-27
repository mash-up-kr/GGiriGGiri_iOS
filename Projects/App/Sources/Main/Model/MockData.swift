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
                                    Gifticon(id: 0,
                                             brand: "스타벅스",
                                             name: "아메리카노",
                                             expirationDate: "20220626",
                                             imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                numberOfParticipants: 5,
                                isParticipating: false),
                   GifticonCard(remainingTime: "123초",
                                gifticonInfo:
                                    Gifticon(id: 1,
                                             brand: "스타벅스",
                                             name: "아메리카노",
                                             expirationDate: "20220626",
                                             imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                numberOfParticipants: 5,
                                isParticipating: false),
                   GifticonCard(remainingTime: "123초",
                                gifticonInfo:
                                    Gifticon(id: 2,
                                             brand: "스타벅스",
                                             name: "아메리카노",
                                             expirationDate: "20220626",
                                             imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                numberOfParticipants: 5,
                                isParticipating: false)]),
        .category(Category.allCases),
        .gifticonList([GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 3,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220626",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 4,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220627",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 5,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220628",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 6,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220629",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 7,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220630",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 8,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220701",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 9,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220702",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 10,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220703",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 11,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220704",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 12,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220705",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 13,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220704",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false),
                       GifticonCard(remainingTime: "123초",
                                    gifticonInfo:
                                        Gifticon(id: 14,
                                                 brand: "스타벅스",
                                                 name: "아메리카노",
                                                 expirationDate: "20220705",
                                                 imageUrl: "https://item.kakaocdn.net/do/c9230634b95167d3f4c177bb02c9f73d4022de826f725e10df604bf1b9725cfd"),
                                    numberOfParticipants: 5,
                                    isParticipating: false)])
    ]
}

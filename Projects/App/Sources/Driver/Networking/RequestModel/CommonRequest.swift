//
//  CommonRequest.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum CommonRequest {
    enum OrderCase: Encodable {
        case deadLine
        case create
        
        func encode(to encoder: Encoder) throws {
            var contrainer = encoder.singleValueContainer()
            
            switch self {
            case .deadLine:
                try contrainer.encode("DEADLINE")
            case .create:
                try contrainer.encode("CREATED_AT")
            }
        }
    }
    
    enum CategoryCase: Encodable {
        case all
        case cafe
        case delivery
        case icecream
        case convenienceStore
        case fastfood
        case voucher
        case etc
        
        init(categoryModel: Category) {
            switch categoryModel {
            case .all: self = .all
            case .cafe: self = .cafe
            case .delivery: self = .delivery
            case .icecream: self = .icecream
            case .convenienceStore: self = .convenienceStore
            case .fastfood: self = .fastfood
            case .voucher: self = .voucher
            case .etc: self = .etc
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var contrainer = encoder.singleValueContainer()
            
            switch self {
            case .all:
                try contrainer.encode("ALL")
            case .cafe:
                try contrainer.encode("CAFE")
            case .delivery:
                try contrainer.encode("DELIVERY")
            case .icecream:
                try contrainer.encode("ICECREAM")
            case .convenienceStore:
                try contrainer.encode("CONVENIENCE_STORE")
            case .fastfood:
                try contrainer.encode("FAST_FOOD")
            case .voucher:
                try contrainer.encode("VOUCHER")
            case .etc:
                try contrainer.encode("ETC")
            }
        }
    }
}

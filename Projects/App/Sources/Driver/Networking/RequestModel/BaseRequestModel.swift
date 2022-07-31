//
//  BaseRequestModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum BaseReqeustModel {
    enum Order: Encodable {
        case deadLine
        case create
        
        enum CodingKeys: String, CodingKey {
            case deadLine = "DEADLINE"
            case create = "CREATED_AT"
        }
    }
    
    enum Category: Encodable {
        case all
        
        enum CodingKeys: String, CodingKey {
            case all = "ALL"
        }
    }
}

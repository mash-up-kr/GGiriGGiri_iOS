//
//  OCRAPI.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import Alamofire
import UIKit

enum OCRAPI {
    case reqeust(OCRRequestModel)
}

extension OCRAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .reqeust:
            return "/ocr"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .reqeust:
            return .multipartHeader
        }
    }

    var method: HTTPMethod {
        switch self {
        case .reqeust:
            return .post
        }
    }
}

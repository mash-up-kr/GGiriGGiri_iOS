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
    case request(OCRRequestModel)
}

extension OCRAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .request:
            return "/ocr"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .request:
            return .multipartHeader
        }
    }

    var method: HTTPMethod {
        switch self {
        case .request:
            return .post
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .request(let model):
            return model
        }
    }
}

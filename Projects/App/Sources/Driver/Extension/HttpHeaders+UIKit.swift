//
//  HttpHeaders+.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import Alamofire

extension HTTPHeaders {
    static var `default`: HTTPHeaders {
        HTTPHeaders([
            "Authorization" : UIDevice.current.identifierForVendor?.description ?? .init().description
        ])
    }
    
    static var multipartHeader: HTTPHeaders {
        var headers = HTTPHeaders.default
        headers.update(.contentType("multipart/form-data"))
        return headers
    }
}

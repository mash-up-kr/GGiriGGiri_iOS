//
//  NetworkRequestable.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import Alamofire
import UIKit

protocol NetworkRequestable {
    /// Request Path
    var path: String { get }
    /// HttpMethod
    var method: HTTPMethod { get }
    /// Request 시 필요한 parameters
    var parameters: Encodable? { get }
    /// Request Headers
    var headers: HTTPHeaders { get }
    
    /// Endpoint
    /// -  WrongEndPoint Error를 발생시키기 위해 함수로 작성
    func endpoint() throws -> URL
}

// MARK: - Builder

extension NetworkRequestable {
    func endpoint() throws -> URL {
        guard let endpoint = URL(string: baseURL + path) else {
            throw Network.NetworkingError.wrongEndpoint
        }
        return endpoint
    }
}

// MARK: - Preset

extension NetworkRequestable {
    /// Request 시 사용될 BaseURL
    var baseURL: String {
        "https://ddip.sgsg.name"
    }
    
    var path: String {
        ""
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Encodable? {
        nil
    }
    
    var headers: HTTPHeaders {
        HTTPHeaders([
            "Authorization" : UIDevice.current.identifierForVendor?.description ?? .init().description
        ])
    }
}



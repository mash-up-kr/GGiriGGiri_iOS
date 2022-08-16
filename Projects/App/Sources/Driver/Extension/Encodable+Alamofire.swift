//
//  Encodable+Alamofire.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import Alamofire

extension Encodable {
    var requestable: Parameters {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
    }
    
    var multiPartRequestable: [String: Data] {
        do {
            let data = try JSONEncoder().encode(self)
            guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return [:]
            }
            
            var dictionary: [String: Data] = [:]
            for (key, value) in jsonObject {
                guard let valueString = value as? String else { continue }
                dictionary.updateValue(Data(base64Encoded: valueString) ?? Data(), forKey: key)
            }
            
            return dictionary
        } catch {
            return [:]
        }
    }
}

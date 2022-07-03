//
//  PrimitiveSequence+.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element == Networking.Response {
    func map<T: Decodable>() -> Single<T> {
        return flatMap { result in
            switch result {
            case let .success(data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return .just(decodedData)
                } catch {
                    return .error(error)
                }
            case let .failure(error):
                return .error(error)
            }
        }
    }
}

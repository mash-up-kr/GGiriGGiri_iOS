//
//  PrimitiveSequence+.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element == Network.Response {
    func map<T: Decodable>() -> Single<T> {
        return flatMap { result in
            switch result {
            case let .success(data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return .just(decodedData)
                } catch {
                    debugPrint("** DecodeError occurs \(error.localizedDescription)")
                    return .error(error)
                }
            case let .failure(error):
                switch error {
                case .emptyResponse:
                    debugPrint("** EmptyResponseError occurs")
                case let .response(error):
                    debugPrint("** ResponseError occurs \(error.localizedDescription)")
                default:
                    debugPrint("** UnhandledResponseError occurs")
                }
                return .error(error)
            }
        }
    }
}

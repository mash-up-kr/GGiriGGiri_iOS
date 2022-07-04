//
//  Networking.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/01.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

final class Networking {
    typealias Response = Result<Data, AFError>
    
    enum NetworkingError: Error {
        case wrongEndpoint
    }
    
    static func request(_ model: NetworkRequestable) -> Single<Response> {
        .create { single in
            do {
                let endpoint = try model.endpoint()
                AF.request(endpoint).response { [single] response in
                    if let error = response.error {
                        single(.failure(error))
                    }
                    guard let data = response.data else {
                        single(
                            .failure(
                                AFError.responseValidationFailed(reason: .dataFileNil)
                            )
                        )
                        return
                    }
                    
                    single(.success(.success(data)))
                }
                return Disposables.create()
            } catch {
                errorHandling(error)
                single(.failure(error))
                return Disposables.create()
            }
        }
    }
}

// MARK: - Error Handling

extension Networking {
    private static func errorHandling(_ error: Error) {
        guard let error = error as? NetworkingError else {
            debugPrint("Unhandled error occurs \(error.localizedDescription)")
            return
        }
        
        switch error {
        case .wrongEndpoint:
            debugPrint("WrongEndPointError occurs")
        }
    }
}

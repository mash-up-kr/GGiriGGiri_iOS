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

protocol Networking {
    func request(_ model: NetworkRequestable) -> Single<Network.Response>
}

final class Network: Networking {
    typealias Response = Result<Data, NetworkingError>
    
    enum NetworkingError: Error {
        case emptyResponse
        case wrongRequest
        case wrongEndpoint
        case response(AFError)
    }
    
    func request(_ model: NetworkRequestable) -> Single<Response> {
        .create { [weak self] single in
            do {
                let endpoint = try model.endpoint()
                let parameters = model.parameters?.requestable ?? [:]
                AF.request(
                    endpoint,
                    method: model.method,
                    parameters: parameters,
                    headers: model.headers
                ).response { [single] response in
                    if let error = response.error {
                        single(.failure(NetworkingError.response(error)))
                    }
                    guard let data = response.data else {
                        single(.failure(NetworkingError.emptyResponse))
                        return
                    }
                    single(.success(.success(data)))
                }
                return Disposables.create()
            } catch {
                self?.requestErrorHandling(error)
                single(.failure(NetworkingError.wrongRequest))
                return Disposables.create()
            }
        }
    }
    
    func requestMultipartFormData(_ model: NetworkRequestable) -> Single<Response> {
        .create { [weak self] single in
            do {
                let endpoint = try model.endpoint()
                let parameters = model.parameters?.requestable ?? [:]
                AF.upload(
                    multipartFormData: { multipartFormData in
                        for (key, value) in parameters {
                            if key == "image", let value = value as? Data {
                                multipartFormData.append(
                                    value,
                                    withName: key,
                                    fileName: "\(value)"
                                )
                            }
                        }
                    },
                    to: endpoint
                )
                .response{ [single] response in
                    if let error = response.error {
                        single(.failure(NetworkingError.response(error)))
                    }
                    guard let data = response.data else {
                        single(.failure(NetworkingError.emptyResponse))
                        return
                    }
                    single(.success(.success(data)))
                }
                return Disposables.create()
            } catch {
                self?.requestErrorHandling(error)
                single(.failure(NetworkingError.wrongRequest))
                return Disposables.create()
            }
        }
    }
}

// MARK: - Error Handling

extension Network {
    private func requestErrorHandling(_ error: Error) {
        guard let error = error as? NetworkingError else {
            debugPrint("** Unhandled error occurs \(error.localizedDescription)")
            return
        }
        
        switch error {
        case .wrongEndpoint:
            debugPrint("** WrongEndPointError occurs")
        case .wrongRequest:
            debugPrint("** WrongRequestError occurs")
        default:
            debugPrint("** UnhandledReuqestError occurs")
        }
    }
}

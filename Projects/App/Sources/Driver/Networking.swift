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
    typealias Response<T: Decodable> = Result<T, AFError>
    
    static func request<T: Decodable>(type: T.Type) -> Single<Result<T, AFError>> {
        .create { single in
            AF.request("https://m.naver.com").response { [single] response in
                if let error = response.error {
                    single(.failure(error))
                }
                
                guard let data = response.data else {
                    single(
                        .failure(
                            AFError.responseSerializationFailed(reason: .inputFileNil)
                        )
                    )
                    return
                }
                
                do {
                    let deocodedData = try JSONDecoder().decode(T.self, from: data)
                    single(.success(.success(deocodedData)))
                } catch {
                    single(
                        .failure(
                            AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
                        )
                    )
                }
            }
            
            return Disposables.create()
        }
    }
}

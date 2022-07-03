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
    
    static func request() -> Single<Response> {
        .create { single in
            AF.request("https://m.naver.com").response { [single] response in
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
        }
    }
}

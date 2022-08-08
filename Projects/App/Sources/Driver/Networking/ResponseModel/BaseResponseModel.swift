//
//  BaseResponseModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import RxSwift

typealias Response = Single<BaseResponseModel>

struct BaseResponseModel: Decodable {
    let code: String
    let message: String
}

typealias ResponseData<T: Decodable> = Single<BaseDataResponseModel<T>>

struct BaseDataResponseModel<T: Decodable>: Decodable {
    let code: String
    let message: String
    let data: T?
}

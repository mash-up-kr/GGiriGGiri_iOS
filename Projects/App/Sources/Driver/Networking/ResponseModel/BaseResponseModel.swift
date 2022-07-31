//
//  BaseResponseModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import RxSwift

typealias Response<T: Decodable> = Single<BaseResponseModel<T>>

struct BaseResponseModel<T: Decodable>: Decodable {
    let code: String
    let message: String
    let data: T?
}

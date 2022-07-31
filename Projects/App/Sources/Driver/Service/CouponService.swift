//
//  CouponService.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/04.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxSwift

// MARK: SAMPLE

struct CouponService {
    typealias CouponListResponse = Response<[CouponEntity]>
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func list(_ model: ListRquestModel) -> CouponListResponse {
        network.request(CouponAPI.list(model)).map()
    }
}

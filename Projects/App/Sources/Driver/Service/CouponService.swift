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
    typealias CouponListResponse = Single<[CouponEntity]>
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func list() -> CouponListResponse {
        network.request(CouponAPI.list).map()
    }
}

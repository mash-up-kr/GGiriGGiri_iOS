//
//  ApplyViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

protocol ApplyViewModelProtocol {
    var gifticonId: Int { get }
}

final class ApplyViewModel: ApplyViewModelProtocol {
    var gifticonId: Int
    
    init(gifticonId: Int) {
        self.gifticonId = gifticonId
    }
}

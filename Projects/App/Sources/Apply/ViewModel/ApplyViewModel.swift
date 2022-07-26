//
//  ApplyViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

protocol ApplyViewModelProtocol {
    var id: Int { get set }
}

final class ApplyViewModel: ApplyViewModelProtocol {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

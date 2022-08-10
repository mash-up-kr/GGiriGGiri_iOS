//
//  CategoryEntity.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct CategoryEntity {
    private var values: [Category] = []
    
    var all: [Category] {
        values
    }
    
    var expectAll: [Category] {
        values.filter { $0 != .all }
    }
    
    init(_ categoriesModel: [CategoryResponseModel] = []) {
        values = categoriesModel.compactMap { Category(rawValue: $0.rawValue) }
    }
}

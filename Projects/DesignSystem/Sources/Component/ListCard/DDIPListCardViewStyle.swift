//
//  DDIPListCardViewStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/17.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

public struct DDIPListCardViewStyle {
    public let brand: String
    public let name: String
    public let expirationDate: String
    public let iconImage: String
    public let description: String
    
    public init(
        brand: String,
        name: String,
        expirationDate: String,
        iconImage: String,
        description: String
    ) {
        self.brand = brand
        self.name = name
        self.expirationDate = expirationDate
        self.iconImage = iconImage
        self.description = description
    }
}

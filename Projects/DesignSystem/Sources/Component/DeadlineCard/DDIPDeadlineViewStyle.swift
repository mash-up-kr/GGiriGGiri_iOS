//
//  DeadlineViewStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

public struct DDIPDeadlineViewStyle {
    public let time: String
    public let brand: String
    public let name: String
    public let expirationDate: String
    public let iconImage: DDIPAsset.name
    
    public init(
        time: String,
        brand: String,
        name: String,
        expirationDate: String,
        iconImage: DDIPAsset.name
    ) {
        self.time = time
        self.brand = brand
        self.name = name
        self.expirationDate = expirationDate
        self.iconImage = iconImage
    }
}

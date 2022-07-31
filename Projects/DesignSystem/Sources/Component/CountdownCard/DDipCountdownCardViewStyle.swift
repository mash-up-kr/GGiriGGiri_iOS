//
//  DDipCountdownCardViewStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/29.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public struct DDipCountdownCardViewStyle {
    public let iconImage: DDIPAsset.name
    public let time: String
    
    public init(iconImage: DDIPAsset.name, time: String) {
        self.iconImage = iconImage
        self.time = time
    }
}

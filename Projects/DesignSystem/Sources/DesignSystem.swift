//
//  DesignSystem.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum DesignSystem {
    /// DesignSystem에서만 사용될 Constant
    enum Constant {
        private static var bundleId: String { "com.sz.mashup.GGiriGGiri.DesignSystem" }
        static var bundle: Bundle? { Bundle(identifier: bundleId) }
    }
}

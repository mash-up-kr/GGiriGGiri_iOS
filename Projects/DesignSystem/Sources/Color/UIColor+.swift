//
//  UIColor+.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIColor {
    public class func ddip(_ color: DDIPColor) -> UIColor? {
        guard let bundle = DesignSystem.Constant.bundle else { return nil }
        return UIColor(named: color.name, in: bundle, compatibleWith: nil)
    }
}


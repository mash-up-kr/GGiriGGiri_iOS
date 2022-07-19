//
//  UIImage+.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/19.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIImage {
    /// DesignSystem의 에셋
    /// - Parameter name: 사용할 에셋의 name
    public class func designSystem(_ name: DDIPAsset.name) -> UIImage? {
        UIImage(named: name.description, in: DesignSystem.Constant.bundle, with: nil)
    }
}

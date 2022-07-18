//
//  UIView+.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/18.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(with views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}

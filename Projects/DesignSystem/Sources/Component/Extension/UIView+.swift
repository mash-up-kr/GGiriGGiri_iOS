//
//  UIView+.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol addViewsAble {}

extension addViewsAble where Self: UIView {
    func addSubViews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}

//
//  UIStackView+.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/22.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}

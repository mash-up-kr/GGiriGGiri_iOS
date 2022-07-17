//
//  StackView+.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/17.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(with views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}

//
//  UIStackView+.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/05.
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

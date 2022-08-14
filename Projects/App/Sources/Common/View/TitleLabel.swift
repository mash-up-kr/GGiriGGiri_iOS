//
//  TitleLabel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class TitleLabel: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(color: UIColor?,
                     text: String = "",
                     font: UIFont? = .systemFont(ofSize: 17,
                                                 weight: .regular)) {
        self.init()

        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textColor = color
        self.attributedText = NSMutableAttributedString(string: text)
        self.font = font
    }
}

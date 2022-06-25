//
//  CommonButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit
import PinLayout

public class CommonButton: UIButton {
    public let style: CoButtonStyle
    
    public init(frame: CGRect = .zero, style: CoButtonStyle) {
        self.style = style
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUI() {
        self.layer.cornerRadius = self.style.radius
        self.setTitleColor(self.style.titleColor, for: .normal)
        self.backgroundColor = self.style.buttonColor
        self.titleLabel?.font = self.style.buttonFont
        self.setTitle(self.style.title, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: self.style.topInset, left: self.style.leftInset, bottom: self.style.bottomInset, right: self.style.rightInset)
        self.titleLabel?.pin.height(self.style.height.rawValue)
    }
}

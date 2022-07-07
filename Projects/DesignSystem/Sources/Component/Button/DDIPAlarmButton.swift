//
//  DDIPAlarmButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPAlarmButton: UIButton {
    public let style: DDIPAlarmButtonStyle
    
    public init(frame: CGRect = .zero, style: DDIPAlarmButtonStyle) {
        self.style = style
        super.init(frame: frame)
        setButton()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        self.layer.cornerRadius = 5
        self.setTitleColor(self.style.titleColor, for: .normal)
        self.backgroundColor = self.style.buttonColor
        self.titleLabel?.font = .systemFont(ofSize: 12)
        self.setTitle(self.style.title?.rawValue, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: self.style.topInset, left: self.style.leftInset, bottom: self.style.bottomInset, right: self.style.rightInset)
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}

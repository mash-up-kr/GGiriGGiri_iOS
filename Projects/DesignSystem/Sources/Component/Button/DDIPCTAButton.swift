//
//  DDIPCTAButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCTAButton: UIButton {
    public let style: DDIPCTAButtonStyle
    
    public init(frame: CGRect = .zero, style: DDIPCTAButtonStyle) {
        self.style = style
        super.init(frame: frame)
        setButton()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
        self.setTitleColor(self.style.titleColor, for: .normal)
        self.backgroundColor = self.style.buttonColor
        self.titleLabel?.font = .systemFont(ofSize: 16)
        self.setTitle(self.style.title, for: .normal)
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}

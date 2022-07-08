//
//  DDIPCardListButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCardListButton: UIButton {
    public let style: DDIPCardListButtonStyle
    
    public init(frame: CGRect = .zero, style: DDIPCardListButtonStyle) {
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
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.setTitle(self.style.title?.rawValue, for: .normal)
        self.titleLabel?.widthAnchor.constraint(equalToConstant: 52).isActive = true
        self.titleLabel?.textAlignment = .center
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 34),
            self.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
}

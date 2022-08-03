//
//  DDIPCTAButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCTAButton: UIButton {
    public init() {
        super.init(frame: .zero)
        setButton()
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setBackgroundColor(buttonColor: UIColor?) {
        self.backgroundColor = buttonColor
    }

    public func setTitle(title: String) {
        self.setTitle(title, for: .normal)
    }
    
    private func setButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setAttribute() {
        self.layer.cornerRadius = 12

        self.setTitleColor(.designSystem(.neutralWhite), for: .normal)
        self.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._16)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}

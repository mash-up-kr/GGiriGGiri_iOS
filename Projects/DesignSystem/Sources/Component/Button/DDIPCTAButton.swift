//
//  DDIPCTAButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

public class DDIPCTAButton: UIButton {
    public init() {
        super.init(frame: .zero)
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setAttribute() {
        self.layer.cornerRadius = 12

        self.setTitleColor(.designSystem(.neutralWhite), for: .normal)
        self.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._16)
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
    }
}

// MARK: - 외부 주입 메서드

extension DDIPCTAButton {
    public func setBackgroundColor(buttonColor: DDIPColor) {
        self.backgroundColor = UIColor.designSystem(buttonColor)
    }

    public func setTitle(title: String) {
        self.setTitle(title, for: .normal)
    }

    public func isEnable(_ enable: Bool) {
        self.isEnabled = enable
    }
}

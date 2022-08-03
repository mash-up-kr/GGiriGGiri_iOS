//
//  DDIPCardListButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCardListButton: UIButton {
    public enum TitleStatus: String {
        case apply = "응모하기"
        case complete = "응모완료"
        case result = "결과확인"
        case progress = "응모중"
        case failure = "꽝"
        case win = "당첨"

        var value: String {
            return self.rawValue
        }
    }

    public init() {
        super.init(frame: .zero)
        setButton()
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setButtonAttribute(titleStatus: TitleStatus, buttonColor: UIColor?, isHidden: Bool) {
        self.setTitle(titleStatus.value, for: .normal)
        self.isHidden = isHidden
        self.backgroundColor = buttonColor
    }
    
    private func setButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setAttribute() {
        self.layer.cornerRadius = 12

        self.setTitleColor(.designSystem(.neutralWhite), for: .normal)
        self.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._14)
        self.titleLabel?.textAlignment = .center

    }
    
    private func setLayout() {
        self.titleLabel?.widthAnchor.constraint(equalToConstant: 52).isActive = true

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 34),
            self.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
}

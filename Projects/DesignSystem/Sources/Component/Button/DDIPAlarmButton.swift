//
//  DDIPAlarmButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

public class DDIPAlarmButton: UIButton {
    public enum TitleStatus: String {
        case checkResult = "결과 확인"
        case confirmed = "확인 완료"
    }

    public init() {
        super.init(frame: .zero)
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setEdgeInset(
        topInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat,
        bottomInset: CGFloat) {
            self.contentEdgeInsets = .init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }

    private func setAttribute() {
        self.layer.cornerRadius = 5
        self.setTitleColor(.designSystem(.neutralWhite), for: .normal)
        self.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._12)
    }


    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(34)
        }
    }
}

// MARK: - 외부 주입 메서드

extension DDIPAlarmButton {
    public func setBackgroundColor(_ backgroundColor: DDIPColor) {
        self.backgroundColor = UIColor.designSystem(backgroundColor)
    }

    public func setTitle(_ title: TitleStatus) {
        self.setTitle(title.rawValue, for: .normal)
    }

    public func isEnable(_ enable: Bool) {
        self.isEnabled = enable
    }
}

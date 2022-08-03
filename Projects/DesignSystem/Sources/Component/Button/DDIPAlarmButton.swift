//
//  DDIPAlarmButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPAlarmButton: UIButton {
    public enum TitleStatus: String {
        case checkResult = "결과 확인"
        case confirmed = "확인 완료"
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

    public func setBackgroundColor(_ backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
    }

    public func setTitle(_ title: TitleStatus) {
        self.setTitle(title.rawValue, for: .normal)
    }

    public func setEdgeInset(
        topInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat,
        bottomInset: CGFloat) {
            self.contentEdgeInsets = .init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
    
    private func setButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setAttribute() {
        self.layer.cornerRadius = 5
        self.setTitleColor(.designSystem(.neutralWhite), for: .normal)
        self.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._12)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}

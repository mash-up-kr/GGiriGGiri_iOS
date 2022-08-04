//
//  DDIPCategoryButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCategoryButton: UIButton {
    public enum ButtonHeight: CGFloat {
        case height_34 = 34
        case height_36 = 36
    }

    public init() {
        super.init(frame: .zero)
        setButton()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    private func setButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setAttribute() {
        self.layer.cornerRadius = 17

        self.setTitleColor(.designSystem(.neutralWhite), for: .normal)
        self.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._14)
    }
}

// MARK: - 외부 주입 메서드

extension DDIPCategoryButton {
    public func setBackgroundColor(_ color: DDIPColor) {
        self.backgroundColor = UIColor.designSystem(color)
    }

    public func setButtonTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }

    public func setHeight(_ height: ButtonHeight) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height.rawValue),
        ])
    }

    public func setEdgeInset(
        topInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat,
        bottomInset: CGFloat) {
            self.contentEdgeInsets = .init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
}

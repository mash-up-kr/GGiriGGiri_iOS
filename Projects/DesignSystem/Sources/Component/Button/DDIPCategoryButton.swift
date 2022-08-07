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
    
    public override var isSelected: Bool {
        didSet {
            updateFont()
            updateBorder()
        }
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

        self.setTitleColor(.designSystem(.neutralBlack), for: .normal)
        self.setTitleColor(.designSystem(.neutralWhite), for: .selected)
        
        self.setBackgroundColor(.designSystem(.neutralWhite), for: .normal)
        self.setBackgroundColor(.designSystem(.secondaryBlue), for: .selected)
        
        setEdgeInset(topInset: 7, leftInset: 20, rightInset: 20, bottomInset: 7)
        
        updateFont()
        updateBorder()
    }
    
    private func updateFont() {
        self.titleLabel?.font = isSelected ?
            .designSystem(.pretendard, family: .bold, size: ._14) :
            .designSystem(.pretendard, family: .medium, size: ._14)
    }
    
    private func updateBorder() {
        self.layer.borderWidth = isSelected ? .zero : 0.5
        self.layer.borderColor = isSelected ?
            UIColor.clear.cgColor :
            UIColor.designSystem(.neutralGray300)?.cgColor
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
        
        self.layer.cornerRadius = height == .height_34 ? 17 : 18
    }

    public func setEdgeInset(
        topInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat,
        bottomInset: CGFloat) {
            self.contentEdgeInsets = .init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
}

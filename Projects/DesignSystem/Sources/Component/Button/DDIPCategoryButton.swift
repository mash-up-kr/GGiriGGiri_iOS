//
//  DDIPCategoryButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCategoryButton: UIButton {
    public let style: DDIPCategoryButtonStyle
    
    public init(frame: CGRect = .zero, style: DDIPCategoryButtonStyle) {
        self.style = style
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        self.setTitleColor(self.style.titleColor, for: .normal)
        self.backgroundColor = self.style.buttonColor
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.setTitle(self.style.title, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: self.style.topInset, left: self.style.leftInset, bottom: self.style.bottomInset, right: self.style.rightInset)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: self.style.height.rawValue),
        ])
    }
}

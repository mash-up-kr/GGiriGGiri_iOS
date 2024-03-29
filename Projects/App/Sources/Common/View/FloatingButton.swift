//
//  FloatingButton.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class FloatingButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    convenience init(title: String) {
        self.init()
        
        configureFloatingButton(with: title)
    }
    
    private func configure() {
        self.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.layer.frame.size.width / 2
        self.backgroundColor = .black
        self.setImage(.designSystem(.iconCrossFill48), for: .normal)
        self.tintColor = .designSystem(.neutralWhite)
    }
    
    private func configureFloatingButton(with title: String) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.layer.frame.size.width / 2
        self.backgroundColor = .black
        self.setImage(nil, for: .normal)
        self.setTitle(title, for: .normal)
        self.tintColor = .designSystem(.neutralWhite)
    }
}

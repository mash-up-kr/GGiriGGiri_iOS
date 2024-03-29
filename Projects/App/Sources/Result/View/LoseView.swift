//
//  LoseView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class LoseView: BaseView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = .designSystem(.iconLose)
        return imageView
    }()
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(94)
            $0.centerX.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        
        backgroundColor = .clear
    }
}

//
//  CommonInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/01.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class CommonInfoView: BaseView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .medium, size: ._14)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "카페/디저트"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._14)
        return label
    }()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [titleLabel, infoLabel])
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .clear
    }
    
    func configure(title: String, info: String) {
        titleLabel.text = title
        infoLabel.text = info
    }
}

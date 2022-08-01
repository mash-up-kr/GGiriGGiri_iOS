//
//  ApplyInformationLabelView.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/01.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class ApplyInformationLabelView: BaseView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .medium, size: ._14)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._14)
        return label
    }()
    
    init(_ title: String? = nil, _ description: String? = nil) {
        titleLabel.text = title
        descriptionLabel.text = description
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [titleLabel, descriptionLabel])
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        backgroundColor = .clear
    }
    
    func configure(title: String?) {
        titleLabel.text = title
    }
    
    func configure(information: String?) {
        descriptionLabel.text = information
    }
    
    func configure(title: String?, information: String?) {
        configure(title: title)
        configure(information: information)
    }
}

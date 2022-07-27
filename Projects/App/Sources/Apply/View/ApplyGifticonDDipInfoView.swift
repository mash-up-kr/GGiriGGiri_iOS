//
//  ApplyGifticonDDipInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/27.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 응모 뷰 > 뿌리기 정보 뷰
final class ApplyGifticonDDipInfoView: BaseView {
    
    private let ddipInfoSectionTitleLabel = TempLabel(
        color: .black,
        text: "뿌리기 정보",
        font: .designSystem(.pretendard, family: .bold, size: ._18)
    )
    
    private let infoContainerView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .designSystem(.neutralGray100)
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 27
        return stackView
    }()
    
    private let categoryContainerView = InfoView()
    
    override func setLayout() {
        super.setLayout()
        
        verticalStackView.addArrangedSubview(categoryContainerView)
        infoContainerView.addSubview(verticalStackView)
        addSubviews(with: [ddipInfoSectionTitleLabel, infoContainerView])
        
        ddipInfoSectionTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(ddipInfoSectionTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    override func configure() {
        super.configure()
        
        infoContainerView.layer.cornerRadius = 12
        
        categoryContainerView.configure(title: "현재 참여자", info: 24)
    }
}

fileprivate class InfoView: BaseView {
    
    private let titleLabel = TempLabel(
        color: .designSystem(.neutralBlack),
        text: "현재 참여자",
        font: .designSystem(.pretendard, family: .medium, size: ._14)
    )
    
    private let infoLabel = TempLabel(
        color: .designSystem(.neutralBlack),
        text: "24명",
        font: .designSystem(.pretendard, family: .bold, size: ._14)
    )
    
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
    
    func configure(title: String, info: Int) {
        titleLabel.text = title
        infoLabel.text = "\(info)명"
    }
}

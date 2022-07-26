//
//  ApplyGifticonInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/27.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 응모 뷰 > 기프티콘 정보 뷰
final class ApplyGifticonInfoView: BaseView {

    private let gifticonInfoSectionTitleLabel = TempLabel(
        color: .black,
        text: "기프티콘 정보",
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
    private let brandContainerView = InfoView()
    private let productContainerView = InfoView()
    private let expirationDateContainerView = InfoView()
    
    override func setLayout() {
        super.setLayout()
        
        
        verticalStackView.addArrangedSubviews(with: [categoryContainerView,
                                                     brandContainerView,
                                                     productContainerView,
                                                     expirationDateContainerView])
        infoContainerView.addSubview(verticalStackView)
        addSubviews(with: [gifticonInfoSectionTitleLabel, infoContainerView])
        
        gifticonInfoSectionTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(gifticonInfoSectionTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(204)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    override func configure() {
        super.configure()
        
        infoContainerView.layer.cornerRadius = 12
        
        categoryContainerView.configure(title: "카테고리", info: "카페/디저트")
        brandContainerView.configure(title: "브랜드", info: "스타벅스")
        productContainerView.configure(title: "제품명", info: "아이스 아메리카노 R")
        expirationDateContainerView.configure(title: "유효기간", info: "2022.02.03")
    }
}

fileprivate class InfoView: BaseView {
    
    private let titleLabel = TempLabel(
        color: .designSystem(.neutralBlack),
        text: "카테고리",
        font: .designSystem(.pretendard, family: .medium, size: ._14)
    )
    
    private let infoLabel = TempLabel(
        color: .designSystem(.neutralBlack),
        text: "카페/디저트",
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
    
    func configure(title: String, info: String) {
        titleLabel.text = title
        infoLabel.text = info
    }
}

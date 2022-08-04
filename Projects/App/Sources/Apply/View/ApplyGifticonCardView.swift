//
//  ApplyGifticonCardView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 응모 뷰 > 기프티콘 응모 카드 뷰 (타이머, 이미지 표시)
final class ApplyGifticonCardView: BaseView {
    
    private let deadLineTitleLabel = TempLabel(
        color: .black,
        text: "응모 마감까지",
        font: .designSystem(.pretendard, family: .bold, size: ._20)
    )
    
    private let gifticonTimeView = ApplyGifticonTimeView()
    private let gifticonImageView = UIImageView()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [deadLineTitleLabel, gifticonTimeView, gifticonImageView])
        
        deadLineTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
        }
        
        gifticonTimeView.snp.makeConstraints {
            $0.top.equalTo(deadLineTitleLabel.snp.bottom).offset(28)
            $0.width.equalTo(305)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        gifticonImageView.snp.makeConstraints {
            $0.top.equalTo(gifticonTimeView.snp.bottom).offset(29)
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    override func configure() {
        super.configure()
        
        layer.borderColor = UIColor.designSystem(.neutralGray300)?.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 15
        
        gifticonImageView.contentMode = .scaleAspectFit
        // TODO: 서버에서 내려준 카테고리에 따라 에셋 사용하기
        gifticonImageView.image = UIImage(systemName: "pencil")
    }
}

/// 기프티콘 응모 > 기프티콘 응모 카드 뷰 > 타이머 표시 뷰
fileprivate class ApplyGifticonTimeView: BaseView {
    
    override func configure() {
        super.configure()
        
        backgroundColor = .designSystem(.secondarySkyblue100)
    }
}

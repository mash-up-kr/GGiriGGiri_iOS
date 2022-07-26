//
//  ApplyGifticonView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/27.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 응모 뷰
final class ApplyGifticonView: BaseView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .designSystem(.neutralWhite)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let gifticonCardView = ApplyGifticonCardView()
    private let gifticonInfoView = ApplyGifticonInfoView()
    private let gifticonDDipInfoView = ApplyGifticonDDipInfoView()
    
    private let infoLabel = TempLabel(
        color: .designSystem(.neutralBlack),
        text: "결과 정보는 마감 후 바로 나옵니다.",
        font: .designSystem(.pretendard, family: .bold, size: ._16)
    )
    
    private let applyButton = TempButton(title: "지금 당장 응모할게요!")
    
    override func setLayout() {
        super.setLayout()
        
        scrollView.addSubviews(with: [gifticonCardView,
                                      gifticonInfoView,
                                      gifticonDDipInfoView,
                                      infoLabel,
                                      applyButton])
        
        addSubviews(with: [scrollView, applyButton])
        
        gifticonCardView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(393)
        }
        
        gifticonInfoView.snp.makeConstraints {
            $0.top.equalTo(gifticonCardView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(gifticonCardView)
            $0.height.equalTo(248)
        }
        
        gifticonDDipInfoView.snp.makeConstraints {
            $0.top.equalTo(gifticonInfoView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(gifticonCardView)
            $0.height.equalTo(104)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(gifticonDDipInfoView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-37)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(infoLabel.snp.bottom).offset(37)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(infoLabel.snp.bottom).offset(37)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(54)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

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
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let gifticonCardView = ApplyGifticonCardView()
    private let gifticonInfoView = ApplyGifticonInfoView()
    private let gifticonDDipInfoView = ApplyGifticonDDipInfoView()
    
    private let infoLabel = TempLabel(
        color: .designSystem(.neutralBlack),
        text: "결과 정보는 마감 후 바로 나옵니다.",
        font: .designSystem(.pretendard, family: .bold, size: ._16)
    )
    
    override func setLayout() {
        super.setLayout()
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubviews(with: [
            gifticonCardView,
            gifticonInfoView,
            gifticonDDipInfoView,
            infoLabel
        ])
        
        gifticonCardView.snp.makeConstraints {
            $0.height.equalTo(393)
        }
        
        gifticonInfoView.snp.makeConstraints {
            $0.height.equalTo(248)
        }
        
        gifticonDDipInfoView.snp.makeConstraints {
            $0.height.equalTo(104)
        }
        
        infoLabel.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
    
    override func configure() {
        super.configure()
    }
}

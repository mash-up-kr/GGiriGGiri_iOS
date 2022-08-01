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
    
    private let countdownView: DDipCountdownCardView = {
        let view = DDipCountdownCardView(timerType: .second)
        view.layer.borderColor = UIColor.designSystem(.neutralGray200)?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let informationView = ApplyGifticonInfoView()
    private let ddipInformationView = ApplyGifticonDDipInfoView()
    
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "결과 정보는 마감 후 바로 나옵니다."
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._16)
        label.textAlignment = .center
        return label
    }()
    
    override func setLayout() {
        super.setLayout()
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubviews(with: [
            countdownView,
            informationView,
            ddipInformationView,
            noticeLabel
        ])
        
        stackView.setCustomSpacing(29, after: countdownView)
        stackView.setCustomSpacing(24, after: informationView)
        stackView.setCustomSpacing(28, after: ddipInformationView)
        
        countdownView.snp.makeConstraints {
            $0.height.equalTo(394)
        }
    }
    
    func updateCountdownDate(date: Date) {
        countdownView.update(countdownDate: date)
    }
}

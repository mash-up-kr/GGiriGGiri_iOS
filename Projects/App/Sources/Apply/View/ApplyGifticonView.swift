//
//  ApplyGifticonView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/27.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxRelay
import RxSwift
import SnapKit
import SwiftyGif

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
    private let applyInformationView = ApplyGifticonInfoView()
    private let gifticonInformationView = ApplyGifticonDDipInfoView()
    
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "결과 정보는 마감 후 바로 나옵니다."
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._16)
        label.textAlignment = .center
        return label
    }()
    
    private let disposeBag = DisposeBag()
    let countdownTimeOver = PublishRelay<Void>()
    
    override func configure() {
        super.configure()
        
        countdownView.countdownTimeOver
            .bind(to: countdownTimeOver)
            .disposed(by: disposeBag)
    }
    
    override func setLayout() {
        super.setLayout()
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubviews(with: [
            countdownView,
            applyInformationView,
            gifticonInformationView,
            noticeLabel
        ])
        
        stackView.setCustomSpacing(29, after: countdownView)
        stackView.setCustomSpacing(24, after: applyInformationView)
        stackView.setCustomSpacing(28, after: gifticonInformationView)
        
        countdownView.snp.makeConstraints {
            $0.height.equalTo(394)
        }
    }
    
    func setCountdownDate(date: Date?) {
        guard let date = date else {
            return
        }

        countdownView.update(countdownDate: date)
    }

    func setImageIcon(imageName: DDIPAsset.name? = nil) {
        guard let imageName = imageName else {
            return
        }

        countdownView.update(imageName: imageName)
    }

    func setParticipant(participants: Int) {
        gifticonInformationView.setParticipantLabelView(participants: participants)
    }

    func setCategory(name: String) {
        applyInformationView.setCategoryLabelView(name)
    }

    func setBrand(name: String) {
        applyInformationView.setBrandLabelView(name)
    }

    func setProductName(name: String) {
        applyInformationView.setProductNameLabelView(name)
    }

    func setExpirationDate(name: String) {
        applyInformationView.setExpirationDateLabelView(name.format(.dotYearMonthDay))
    }
}

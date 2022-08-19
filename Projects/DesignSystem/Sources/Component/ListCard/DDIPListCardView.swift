//
//  DDIPListCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/17.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift
import RxRelay
import SnapKit

public class DDIPListCardView: UIView, AddViewsable {
    public enum ViewType {
        case apply           // 응모하기, 응모완료
        case appliedStatus   // 결과확인, 응모중, 꽝, 당첨
        case drawStatus      // 전달완료, 진행중, 받은사람 없음
    }
    
    public enum DrawStatus: String {
        /// 응모 진행 중
        case apply
        
        /// 전달 완료
        case complete
        
        /// 받은 사람 없음
        case nobody
        
        /// drawLabel에 적용될 문구
        var description: String {
            switch self {
            case .apply: return "응모 진행 중"
            case .complete: return "전달 완료"
            case .nobody: return "받은 사람 없음"
            }
        }
    }

    private var type: ViewType {
        didSet {
            updateFromApplyStatus()
        }
    }
    private let applyViewer = DDIPApplyViewer()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let expirationLabel = UILabel()
    private let imageIcon = UIImageView()
    private let dashedLine = DashedLine()

    public let productStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    public let componentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()
    
    private let semiCircleSpaceLeftView: SpaceView = {
        let view = SpaceView(isClockwise: false)
        
        return view
    }()
    private let semiCircleSpaceRightView: SpaceView = {
        let view = SpaceView(isClockwise: true)
        
        return view
    }()
    
    private let deadlineViewComponent: DDipListCardDeadlineView = {
        let view = DDipListCardDeadlineView()

        return view
    }()
    private let applyViewComponent: DDipListCardApplyView = {
        let view = DDipListCardApplyView()

        return view
    }()
    private let completeViewCmponent: DDipListCardCompleteView = {
        let view = DDipListCardCompleteView()

        return view
    }()
    
    public let cardListButtonDidTapped = PublishRelay<ViewType?>()
    private let disposeBag = DisposeBag()
    
    public init(type: ViewType) {
        self.type = type
        super.init(frame: .zero)
        setView()
        setUI()
        setAttribute()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.addSubViews([
            productStackView,
            imageIcon,
            applyViewer,
            dashedLine,
            semiCircleSpaceLeftView, semiCircleSpaceRightView,
            componentStackView
        ])
        productStackView.addArrangedSubviews(
            brandLabel,
            nameLabel,
            expirationLabel
        )
        componentStackView.addArrangedSubviews(
            deadlineViewComponent,
            applyViewComponent,
            completeViewCmponent
        )
    }
    
    private func setAttribute() {
        self.backgroundColor = .designSystem(.neutralWhite)
        self.layer.cornerRadius = 8

        brandLabel.textColor = .designSystem(.neutralBlack)
        nameLabel.textColor = .designSystem(.neutralBlack)
        expirationLabel.textColor = .designSystem(.neutralGray500)

        brandLabel.font = .designSystem(.pretendard, family: .medium, size: ._12)
        nameLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        expirationLabel.font = .designSystem(.pretendard, family: .regular, size: ._12)
        
        updateFromApplyStatus()
    }
    
    private func setUI() {
        self.snp.makeConstraints {
            $0.height.equalTo(180)
        }

        productStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(imageIcon.snp.leading).inset(-17)
        }

        imageIcon.snp.makeConstraints {
            $0.width.height.equalTo(75)
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(55)
        }

        applyViewer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
        }

        dashedLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalTo(semiCircleSpaceLeftView.snp.trailing)
            $0.trailing.equalTo(semiCircleSpaceRightView.snp.leading)
            $0.bottom.equalToSuperview().inset(82)
        }

        semiCircleSpaceLeftView.snp.makeConstraints {
            $0.height.width.equalTo(18)
            $0.leading.equalToSuperview().inset(-9)
            $0.centerY.equalTo(dashedLine.snp.centerY)
        }

        semiCircleSpaceRightView.snp.makeConstraints {
            $0.height.width.equalTo(18)
            $0.trailing.equalToSuperview().inset(-9)
            $0.centerY.equalTo(dashedLine.snp.centerY)
        }

        componentStackView.snp.makeConstraints {
            $0.top.equalTo(productStackView.snp.bottom).inset(-42)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func bind() {
        Observable.merge(
            deadlineViewComponent.cardListButton.rx.tap.asObservable(),
            applyViewComponent.cardListButton.rx.tap.asObservable(),
            completeViewCmponent.cardListButton.rx.tap.asObservable()
        )
        .map { [weak self] in self?.type }
        .bind(to: cardListButtonDidTapped)
        .disposed(by: disposeBag)
    }
    
    private func updateFromApplyStatus() {
        switch type {
        case .apply:
            deadlineViewComponent.isHidden = false
            applyViewComponent.isHidden = true
            completeViewCmponent.isHidden = true
        case .appliedStatus:
            deadlineViewComponent.isHidden = true
            applyViewComponent.isHidden = false
            completeViewCmponent.isHidden = true
        case .drawStatus:
            deadlineViewComponent.isHidden = true
            applyViewComponent.isHidden = true
            completeViewCmponent.isHidden = false
        }
    }
}

// MARK: - 외부 주입 메서드

extension DDIPListCardView {
    public func setApplyViewType(
        status: DDIPCardListButton.ApplyStatus,
        leftTime: Date
    ) {
        type = .apply
        
        deadlineViewComponent.setCardListButton(status)
        
        let drawLabelTitle: String  = {
            switch status {
            case .enable: return "마감"
            case .complete: return "결과"
            }
        }()

        deadlineViewComponent.setDrawLabel(title: drawLabelTitle, leftTime: leftTime)
    }

    public func setAppliedStatusViewType(
        status: DDIPCardListButton.AppliedStatus,
        applyDate: Date
    ) {
        type = .appliedStatus
        
        applyViewComponent.setCardListButton(status)
        applyViewComponent.setDrawLabel(applyDate: applyDate)
    }
    
    public func setDrawStatusViewType(
        drawDate: Date? = nil,
        status: DrawStatus
    ) {
        type = .drawStatus
        
        completeViewCmponent.setDrawLabel(drawDate: drawDate, registerStatus: status.description)
    }

    public func setBrandName(brand: String) {
        brandLabel.text = brand
    }

    public func setName(name: String) {
        nameLabel.text = name
    }

    public func setExpirationDate(expirationDate: Date) {
        expirationLabel.text = "유효기간 : \(expirationDate.fullDateString(.dot))"
    }

    public func setImageIcon(image: DDIPAsset.name) {
        imageIcon.image = .designSystem(image)
    }

    public func setApplyViewer(viewer: Int) {
        applyViewer.setViewer(viewer: viewer)
    }
}

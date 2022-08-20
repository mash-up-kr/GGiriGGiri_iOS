//
//  DDIPDeadlineCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift
import RxRelay
import SnapKit
import SwiftyGif

public class DDIPDeadlineCardView: UIView, AddViewsable {
    public let CTAButton = DDIPCTAButton()
    private let applyViewer = DDIPApplyViewer()
    
    private let imageIcon = UIImageView()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let expirationLabel = UILabel()
    private let dashedLine = DashedLine()
    
    private let firstMinuteView = DDIPTimeView(displayType: .minute)
    private let lastMinuteView = DDIPTimeView(displayType: .minute)
    private let firstSecondView = DDIPTimeView(displayType: .minute)
    private let lastSecondView = DDIPTimeView(displayType: .minute)
    
    private let timer = DDIPCountDownTimer(.second)
    private var disposeBag = DisposeBag()
    
    public let buttonTapEvent = PublishRelay<Void>()
    public let countdownTimeOver = PublishRelay<Void>()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
                                    
        return stackView
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textAlignment = .center
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.chakrapeth, family: .bold, size: ._20)

        return label
    }()
    
    private let semiCircleSpaceLeftView: SpaceView = {
        let view = SpaceView(isClockwise: false)
        
        return view
    }()
    
    private let semiCircleSpaceRightView: SpaceView = {
        let view = SpaceView(isClockwise: true)
        
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setView()
        setUI()
        setValue()
        setFont()
        setAttribute()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {        
        firstMinuteView.numberLabel.textColor = .designSystem(.neutralBlack)
        lastMinuteView.numberLabel.textColor = .designSystem(.neutralBlack)
        firstSecondView.numberLabel.textColor = .designSystem(.dangerRaspberry)
        lastSecondView.numberLabel.textColor = .designSystem(.dangerRaspberry)
        brandLabel.textColor = .designSystem(.neutralBlack)
        nameLabel.textColor = .designSystem(.neutralBlack)
        expirationLabel.textColor = .designSystem(.neutralGray500)
        
    }
    
    private func setFont() {
        nameLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        brandLabel.font = .designSystem(.pretendard, family: .regular, size: ._12)
        expirationLabel.font = .designSystem(.pretendard, family: .regular, size: ._12)
        firstMinuteView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
        lastMinuteView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
        firstSecondView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
        lastSecondView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
    }
    
    private func setView() {
        self.addSubViews([timeStackView, imageIcon, applyViewer, CTAButton, infoStackView, dashedLine, semiCircleSpaceLeftView, semiCircleSpaceRightView])
        infoStackView.addArrangedSubviews(
            brandLabel,
            nameLabel,
            expirationLabel
        )
        timeStackView.addArrangedSubviews(
            firstMinuteView,
            lastMinuteView,
            numberLabel,
            firstSecondView,
            lastSecondView
        )
    }
    
    private func setValue() {
        self.backgroundColor = .designSystem(.neutralWhite)
        self.layer.cornerRadius = 12
        self.backgroundColor = .designSystem(.neutralWhite)
    }

    private func setUI() {
        timeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
        }
        
        imageIcon.snp.makeConstraints {
            $0.top.equalTo(timeStackView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        
        dashedLine.snp.makeConstraints {
            $0.top.equalTo(imageIcon.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        semiCircleSpaceLeftView.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalTo(dashedLine.snp.centerY)
            $0.leading.equalToSuperview().offset(-9)
        }
        
        semiCircleSpaceRightView.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalTo(dashedLine.snp.centerY)
            $0.trailing.equalToSuperview().offset(9)
        }
        
        applyViewer.snp.makeConstraints {
            $0.top.equalTo(dashedLine.snp.bottom).offset(14)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.greaterThanOrEqualTo(infoStackView.snp.trailing).inset(16)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(dashedLine.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(applyViewer.snp.leading).inset(-10)
        }
        
        CTAButton.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func bind() {
        bindingTimer()
        
        CTAButton.rx.tap.bind(to: buttonTapEvent)
            .disposed(by: disposeBag)
    }
    
    private func bindingTimer() {
        timer.minute
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let minute = $0 else { return }
                self?.update(minute: minute)
            })
            .disposed(by: disposeBag)
        
        timer.second
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let second = $0 else { return }
                self?.update(second: second)
            })
            .disposed(by: disposeBag)
        
        timer.invalidDate
            .bind(to: countdownTimeOver)
            .disposed(by: disposeBag)
    }
    
    private func update(minute: Int) {
        firstMinuteView.update(text: "\(minute / 10)")
        lastMinuteView.update(text: "\(minute % 10)")
    }
    
    private func update(second: Int) {
        firstSecondView.update(text: "\(second / 10)")
        lastSecondView.update(text: "\(second % 10)")
    }
}

extension DDIPDeadlineCardView {
    public func update(style: DDIPDeadlineViewStyle) {
        disposeBag = DisposeBag()
        bind()
        
        do {
            let gif = try UIImage(gifName: style.iconImage.description)
            imageIcon.setGifImage(gif)
        } catch {
            print(error)
        }
        
        nameLabel.text = style.name
        brandLabel.text = style.brand
        expirationLabel.text = "유효기간 : \(style.expirationDate.format(.dotYearMonthDay))"
        update(countDownDate: style.time.fullStringDate())
    }
    
    public func update(countDownDate: Date?) {
        timer.update(date: countDownDate)
    }
    
    public func update(buttonTitle: String, backgroundColor: DDIPColor) {
        CTAButton.setTitle(title: buttonTitle)
        CTAButton.setBackgroundColor(buttonColor: backgroundColor)
    }
    
    public func update(viewerCount: Int) {
        applyViewer.setViewer(viewer: viewerCount)
    }

    public func disableButton() {
        CTAButton.isEnabled = false
    }

    public func enableButton() {
        CTAButton.isEnabled = true
    }
}

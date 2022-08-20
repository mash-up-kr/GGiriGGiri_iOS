//
//  DDipCountdownCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/29.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift
import SnapKit

public class DDipCountdownCardView: UIView, AddViewsable {
    private let firstTimeView = DDIPTimeView(displayType: .second)
    private let secondTimeView = DDIPTimeView(displayType: .second)
    private let firstMinuteView = DDIPTimeView(displayType: .second)
    private let secondMinuteView = DDIPTimeView(displayType: .second)
    private let firstSecondView = DDIPTimeView(displayType: .second)
    private let secondSecondView = DDIPTimeView(displayType: .second)
    
    public let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let minuteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .designSystem(.pretendard, family: .bold, size: ._20)
        label.textColor = .designSystem(.neutralBlack)
        label.text = "응모 마감까지"

        return label
    }()
    
    public let separatorWithTimeAndMinuteLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textAlignment = .center
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.chakrapeth, family: .bold, size: ._28)

        return label
    }()
    
    public let separatorWithMinuteAndSecondLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textAlignment = .center
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.chakrapeth, family: .bold, size: ._28)

        return label
    }()
    
    public let entireTimeStackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    private var timer = DDIPCountDownTimer(.second)
    public let countdownTimeOver = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
    
    public init() {
        super.init(frame: .zero)
        setView()
        setStackView()
        setUI()
        setValue()
        bind()
    }
    
    public init(timerType: DDIPCountDownTimer.CountDownType) {
        super.init(frame: .zero)
        timer = DDIPCountDownTimer(timerType)
        setView()
        setStackView()
        setUI()
        setValue()
        bind()
    }
    
    private func bind() {
        bindingTimer()
    }
    
    private func bindingTimer() {
        timer.hour
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let hour = $0 else { return }
                self?.update(hour: hour)
            })
            .disposed(by: disposeBag)
        
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
            .skip(1)
            .bind(to: countdownTimeOver)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.addSubViews([titleLabel, entireTimeStackView, iconImageView])
        entireTimeStackView.addArrangedSubviews(timeStackView, separatorWithTimeAndMinuteLabel, minuteStackView, separatorWithMinuteAndSecondLabel, secondStackView)
    }
    
    private func setValue() {
        self.layer.cornerRadius = 15
        self.backgroundColor = .designSystem(.neutralWhite)
        firstSecondView.numberLabel.textColor = .designSystem(.dangerRaspberry)
        secondSecondView.numberLabel.textColor = .designSystem(.dangerRaspberry)
    }
    
    private func setStackView() {
        timeStackView.addArrangedSubviews(firstTimeView, secondTimeView)
        minuteStackView.addArrangedSubviews(firstMinuteView, secondMinuteView)
        secondStackView.addArrangedSubviews(firstSecondView, secondSecondView)
        
        entireTimeStackView.setCustomSpacing(10, after: timeStackView)
        entireTimeStackView.setCustomSpacing(10, after: separatorWithTimeAndMinuteLabel)

        entireTimeStackView.setCustomSpacing(10, after: minuteStackView)
        entireTimeStackView.setCustomSpacing(10, after: separatorWithMinuteAndSecondLabel)
    }
    
    private func setUI() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().inset(0)
            $0.trailing.lessThanOrEqualToSuperview().inset(0)
        }

        entireTimeStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().inset(0)
            $0.trailing.lessThanOrEqualToSuperview().inset(0)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-20)
            $0.bottom.equalTo(iconImageView.snp.top).inset(-30)
        }

        iconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(10)
            $0.width.height.equalTo(200)
        }
    }
    
    private func update(hour: Int) {
        firstTimeView.update(text: "\(hour / 10)")
        secondTimeView.update(text: "\(hour % 10)")
    }
    
    private func update(minute: Int) {
        firstMinuteView.update(text: "\(minute / 10)")
        secondMinuteView.update(text: "\(minute % 10)")
    }
    
    private func update(second: Int) {
        firstSecondView.update(text: "\(second / 10)")
        secondSecondView.update(text: "\(second % 10)")
    }
}

extension DDipCountdownCardView {
    public func update(imageName: DDIPAsset.name) {
        do {
            let gif = try UIImage(gifName: imageName.description)
            iconImageView.setGifImage(gif)
        } catch {
            print(error)
        }
    }
    
    public func update(countdownDate: Date) {
        timer.update(date: countdownDate)
    }
}

//
//  DDipCountdownCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/29.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift

public class DDipCountdownCardView: UIView, AddViewsable {
    private let firstTimeView = DDIPTimeView(displayType: .second)
    private let secondTimeView = DDIPTimeView(displayType: .second)
    private let firstMinuteView = DDIPTimeView(displayType: .second)
    private let secondMinuteView = DDIPTimeView(displayType: .second)
    private let firstSecondView = DDIPTimeView(displayType: .second)
    private let secondSecondView = DDIPTimeView(displayType: .second)
    
    public let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let minuteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var timer = DDIPCountDownTimer(.second)
    
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
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            entireTimeStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            entireTimeStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0),
            entireTimeStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            entireTimeStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 0),
            entireTimeStackView.bottomAnchor.constraint(equalTo: self.iconImageView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 10),
            iconImageView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10),
            iconImageView.widthAnchor.constraint(equalToConstant: 200),
            iconImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
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
        iconImageView.image = .designSystem(imageName)
    }
    
    public func update(countdownDate: Date) {
        timer.update(date: countdownDate)
    }
}

//
//  DDIPDeadlineCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift

public class DDIPDeadlineCardView: UIView, AddViewsable {
    private let CTAButton = DDIPCTAButton()
    private let applyViewer = DDIPApplyViewer()
    
    private let imageIcon = UIImageView()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let expirationLabel = UILabel()
    private let dashedLine = DashedLine()
    
    private let firstTimeView = DDIPTimeView(displayType: .minute)
    private let secondTimeView = DDIPTimeView(displayType: .minute)
    private let firstMinuteView = DDIPTimeView(displayType: .minute)
    private let secondMinuteView = DDIPTimeView(displayType: .minute)
    
    private let timer = DDIPCountDownTimer(.minute)
    private let disposeBag = DisposeBag()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
                                    
        return stackView
    }()
    
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ":"
        label.textAlignment = .center
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.chakrapeth, family: .bold, size: ._20)

        return label
    }()
    
    private let semiCircleSpaceLeftView: SpaceView = {
        let view = SpaceView(isClockwise: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let semiCircleSpaceRightView: SpaceView = {
        let view = SpaceView(isClockwise: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
        firstTimeView.numberLabel.textColor = .designSystem(.neutralBlack)
        secondTimeView.numberLabel.textColor = .designSystem(.neutralBlack)
        firstMinuteView.numberLabel.textColor = .designSystem(.dangerRaspberry)
        secondMinuteView.numberLabel.textColor = .designSystem(.dangerRaspberry)
        brandLabel.textColor = .designSystem(.neutralBlack)
        nameLabel.textColor = .designSystem(.neutralBlack)
        expirationLabel.textColor = .designSystem(.neutralGray500)
        
    }
    
    private func setFont() {
        nameLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        brandLabel.font = .designSystem(.pretendard, family: .regular, size: ._12)
        expirationLabel.font = .designSystem(.pretendard, family: .regular, size: ._12)
        firstTimeView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
        secondTimeView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
        firstMinuteView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
        secondMinuteView.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._20)
    }
    
    private func setView() {
        applyViewer.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        expirationLabel.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([timeStackView, imageIcon, applyViewer, CTAButton, infoStackView, dashedLine, semiCircleSpaceLeftView, semiCircleSpaceRightView])
        infoStackView.addArrangedSubviews(brandLabel, nameLabel, expirationLabel)
        timeStackView.addArrangedSubviews(firstTimeView, secondTimeView, numberLabel, firstMinuteView, secondMinuteView)
    }
    
    private func setValue() {
        self.backgroundColor = .designSystem(.neutralWhite)
        self.layer.cornerRadius = 12
        self.backgroundColor = .designSystem(.neutralWhite)
    }

    private func setUI() {
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            timeStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            timeStackView.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 16),
            imageIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageIcon.widthAnchor.constraint(equalToConstant: 120),
            imageIcon.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            dashedLine.topAnchor.constraint(equalTo: imageIcon.bottomAnchor, constant: 22),
            dashedLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dashedLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dashedLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            semiCircleSpaceLeftView.heightAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceLeftView.widthAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceLeftView.centerYAnchor.constraint(equalTo: dashedLine.centerYAnchor),
            semiCircleSpaceLeftView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -9),
            
            semiCircleSpaceRightView.heightAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceRightView.widthAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceRightView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 9),
            semiCircleSpaceRightView.bottomAnchor.constraint(equalTo: infoStackView.topAnchor, constant: -7),
        ])
        
        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoStackView.topAnchor.constraint(equalTo: dashedLine.bottomAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.applyViewer.leadingAnchor, constant: -10),
            infoStackView.bottomAnchor.constraint(equalTo: CTAButton.topAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            applyViewer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            applyViewer.topAnchor.constraint(equalTo: infoStackView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            CTAButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            CTAButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            CTAButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
        ])
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
    }
    
    private func update(hour: Int) {
        firstTimeView.update(text: "\(hour / 10)")
        secondTimeView.update(text: "\(hour % 10)")
    }
    
    private func update(minute: Int) {
        firstMinuteView.update(text: "\(minute / 10)")
        secondMinuteView.update(text: "\(minute % 10)")
    }
}

extension DDIPDeadlineCardView {
    public func update(countDownDate: Date?) {
        timer.update(date: countDownDate)
    }
    
    public func update(style: DDIPDeadlineViewStyle) {
        imageIcon.image = .designSystem(style.iconImage)
        nameLabel.text = style.name
        brandLabel.text = style.brand
        expirationLabel.text = "유효기간 : \(style.expirationDate)"
    }
    
    public func update(buttonTitle: String, backgroundColor: DDIPColor) {
        CTAButton.setTitle(title: buttonTitle)
        CTAButton.setBackgroundColor(buttonColor: UIColor.designSystem(backgroundColor))
    }
    
    public func update(viewerCount: String) {
        applyViewer.setViewer(viewer: viewerCount)
    }
    
    // TODO: CTAButton Update Logic 추가해야함
}

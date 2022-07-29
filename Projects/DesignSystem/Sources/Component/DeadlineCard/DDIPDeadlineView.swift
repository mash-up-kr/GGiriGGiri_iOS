//
//  DDIPDeadlineView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPDeadlineView: UIView, AddViewsable {
    public let style: DDIPDeadlineViewStyle
    private let CTAButton: DDIPCTAButton
    private let applyViewer: DDIPApplyViewer
    
    public let imageIcon = UIImageView()
    public let nameLabel = UILabel()
    public let brandLabel = UILabel()
    public let expirationLabel = UILabel()
    private let dashedLine = DashedLine()
    
    private let firstTimeView = TimeView()
    private let secondTimeView = TimeView()
    private let firstMinuteView = TimeView()
    private let secondMinuteView = TimeView()
    
    public let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
                                    
        return stackView
    }()
    
    public let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ":"
        label.textAlignment = .center
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.chakrapeth, family: .bold, size: ._20)

        return label
    }()
    
    let semiCircleSpaceLeftView: SpaceView = {
        let view = SpaceView(isClockwise: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let semiCircleSpaceRightView: SpaceView = {
        let view = SpaceView(isClockwise: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
        
    public init(frame: CGRect = .zero, style: DDIPDeadlineViewStyle, button: DDIPCTAButton, applyViewer: DDIPApplyViewer) {
        self.style = style
        self.CTAButton = button
        self.applyViewer = applyViewer
        super.init(frame: frame)
        setView()
        setUI()
        setValue()
        setFont()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {        
        firstTimeView.numberLabel.textColor = .designSystem(.neutralBlack)
        secondTimeView.numberLabel.textColor = .designSystem(.neutralBlack)
        firstMinuteView.numberLabel.textColor = .designSystem(.dangerRaspberry)
        secondTimeView.numberLabel.textColor = .designSystem(.dangerRaspberry)
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
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 12
        self.backgroundColor = .designSystem(.neutralWhite)

        imageIcon.image = UIImage(systemName: style.iconImage)
        nameLabel.text = style.name
        brandLabel.text = style.brand
        expirationLabel.text = "유효기간 : " + style.expirationDate
        
        firstTimeView.numberLabel.text = style.time
        secondTimeView.numberLabel.text = style.time
        firstMinuteView.numberLabel.text = style.time
        secondMinuteView.numberLabel.text = style.time
    }

    private func setUI() {
        NSLayoutConstraint.activate([
            timeStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0),
            timeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            timeStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 0),
            timeStackView.bottomAnchor.constraint(equalTo: self.imageIcon.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            imageIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 95),
            imageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -95),
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
}

fileprivate final class TimeView: UIView {
    public let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textAlignment = .center

        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = .designSystem(.secondarySkyblue100)
        setUI()
        setValue()
    }
    
    private func setValue() {
        self.layer.cornerRadius = 5
    }
    
    private func setUI() {
        self.addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            numberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7)
        ])
    }
}

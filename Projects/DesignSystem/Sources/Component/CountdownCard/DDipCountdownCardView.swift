//
//  DDipCountdownCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/29.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipCountdownCardView: UIView, AddViewsable {
    public let style: DDipCountdownCardViewStyle
    
    private let firstTimeView = TimeView()
    private let secondTimeView = TimeView()
    private let firstMinuteView = TimeView()
    private let secondMinuteView = TimeView()
    private let firstSecondView = TimeView()
    private let secondSecondView = TimeView()
    
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
    
    public init(frame: CGRect = .zero, style: DDipCountdownCardViewStyle) {
        self.style = style
        super.init(frame: .zero)
        setView()
        setStackView()
        setUI()
        setValue()
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
        iconImageView.image = .designSystem(style.iconImage)
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
        setValue()
        setUI()
    }
    
    private func setValue() {
        self.addSubview(numberLabel)
        self.numberLabel.font = .designSystem(.chakrapeth, family: .bold, size: ._28)
        self.layer.cornerRadius = 12
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            numberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            numberLabel.widthAnchor.constraint(equalToConstant: 19)
        ])
    }
}

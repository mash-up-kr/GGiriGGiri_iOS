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
    private let viwer: DDIPListViewer
    
    public let imageIcon = UIImageView()
    public let nameLabel = UILabel()
    public let brandLabel = UILabel()
    public let expirationLabel = UILabel()
    public let dashedLine = UIView()
    
    public let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
                                    
        return stackView
    }()
    
    public let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    public let separatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ":"
        label.textAlignment = .center

        return label
    }()
    
    public let firstTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        
        return label
    }()
    
    public let secondTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        
        return label
    }()
    
    public let firstMinuteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        
        return label
    }()
    
    public let secondMinuteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        
        return label
    }()
    
    public let spaceLeftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    public let spaceRightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
        
    public init(frame: CGRect = .zero, style: DDIPDeadlineViewStyle, button: DDIPCTAButton, viwer: DDIPListViewer) {
        self.style = style
        self.CTAButton = button
        self.viwer = viwer
        super.init(frame: frame)
        setView()
        setUI()
        setValue()
        setLeftSpaceView()
        setRightSpaceView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        viwer.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        expirationLabel.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([timeStackView, imageIcon, viwer, CTAButton, infoStackView, dashedLine, spaceLeftView, spaceRightView])
        infoStackView.addArrangedSubviews(with: [brandLabel, nameLabel, expirationLabel])
        timeStackView.addArrangedSubviews(with: [firstTimeLabel, secondTimeLabel, separatorLabel, firstMinuteLabel, secondMinuteLabel])
        
        dashedLine.createDottedLine(width: 1, color: UIColor.black.cgColor)
    }
    
    private func setValue() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 12
        
        imageIcon.image = UIImage(systemName: style.iconImage)
        nameLabel.text = style.name
        brandLabel.text = style.brand
        expirationLabel.text = style.expirationDate
        
        firstTimeLabel.text = style.time
        secondTimeLabel.text = style.time
        firstMinuteLabel.text = style.time
        secondMinuteLabel.text = style.time
    }
    
    private func setLeftSpaceView() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width, y: self.bounds.height + 7), radius: 12, startAngle: .pi * 3/2, endAngle: .pi / 2, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.fillColor = UIColor.red.cgColor
        circleShape.path = circlePath.cgPath
        spaceLeftView.layer.addSublayer(circleShape)
    }
    
    private func setRightSpaceView() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width + 18, y: self.bounds.height + 7), radius: 12, startAngle: .pi / 2, endAngle: .pi * 3/2, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.fillColor = UIColor.red.cgColor
        circleShape.path = circlePath.cgPath
        spaceRightView.layer.addSublayer(circleShape)
    }

    private func setUI() {
        NSLayoutConstraint.activate([
            timeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 87.5),
            timeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            timeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -87.5),
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
            spaceLeftView.heightAnchor.constraint(equalToConstant: 18),
            spaceLeftView.widthAnchor.constraint(equalToConstant: 18),
            spaceLeftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            spaceLeftView.bottomAnchor.constraint(equalTo: infoStackView.topAnchor, constant: -7),
            
            spaceRightView.heightAnchor.constraint(equalToConstant: 18),
            spaceRightView.widthAnchor.constraint(equalToConstant: 18),
            spaceRightView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            spaceRightView.bottomAnchor.constraint(equalTo: infoStackView.topAnchor, constant: -7),
        ])
        
        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoStackView.topAnchor.constraint(equalTo: dashedLine.bottomAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: viwer.leadingAnchor, constant: -28),
            infoStackView.bottomAnchor.constraint(equalTo: CTAButton.topAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            viwer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            viwer.bottomAnchor.constraint(equalTo: CTAButton.topAnchor, constant: -54),
            viwer.topAnchor.constraint(equalTo: infoStackView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            CTAButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            CTAButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            CTAButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
        ])
    }
}

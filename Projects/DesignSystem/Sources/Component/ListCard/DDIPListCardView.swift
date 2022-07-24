//
//  DDIPListCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/17.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPListCardView: UIView, AddViewsable {
    public let style: DDIPListCardViewStyle
    private let alarmButton: DDIPCardListButton
    private let applyViewer: DDIPApplyViewer
    
    public let nameLabel = UILabel()
    public let brandLabel = UILabel()
    public let expirationLabel = UILabel()
    public let imageIcon = UIImageView()
    public let dashedLine = UIView()
    public let descriptionLabel = UILabel()
    
    public let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    public let drawStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        return stackView
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
    
    public init(
        frame: CGRect = .zero,
        style: DDIPListCardViewStyle,
        alarmButton: DDIPCardListButton,
        applyViewer: DDIPApplyViewer
    ) {
        self.style = style
        self.alarmButton = alarmButton
        self.applyViewer = applyViewer
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 8
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
        applyViewer.translatesAutoresizingMaskIntoConstraints = false
        alarmButton.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([infoStackView, imageIcon, applyViewer, spaceLeftView, spaceRightView, dashedLine, drawStackView])
        infoStackView.addArrangedSubviews(with: [brandLabel, nameLabel, expirationLabel])
        drawStackView.addArrangedSubviews(with: [alarmButton, descriptionLabel])
    }
    
    private func setValue() {
        brandLabel.text = style.brand
        nameLabel.text = style.name
        expirationLabel.text = style.expirationDate
        imageIcon.image = UIImage(systemName: style.iconImage)
        descriptionLabel.text = style.description
        
        dashedLine.createDottedLine(width: 1, color: UIColor.black.cgColor)
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
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: imageIcon.leadingAnchor, constant: -17),
            infoStackView.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            imageIcon.trailingAnchor.constraint(equalTo: applyViewer.leadingAnchor, constant: -1),
            imageIcon.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -10),
            imageIcon.widthAnchor.constraint(equalToConstant: 75),
            imageIcon.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            applyViewer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -9),
            applyViewer.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            applyViewer.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -68)
        ])
        
        NSLayoutConstraint.activate([
            dashedLine.heightAnchor.constraint(equalToConstant: 1),
            dashedLine.leadingAnchor.constraint(equalTo: self.spaceLeftView.trailingAnchor),
            dashedLine.trailingAnchor.constraint(equalTo: self.spaceRightView.leadingAnchor),
            dashedLine.bottomAnchor.constraint(equalTo: drawStackView.topAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            spaceLeftView.heightAnchor.constraint(equalToConstant: 18),
            spaceLeftView.widthAnchor.constraint(equalToConstant: 18),
            spaceLeftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            spaceLeftView.bottomAnchor.constraint(equalTo: drawStackView.topAnchor, constant: -15),
            
            spaceRightView.heightAnchor.constraint(equalToConstant: 18),
            spaceRightView.widthAnchor.constraint(equalToConstant: 18),
            spaceRightView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            spaceRightView.bottomAnchor.constraint(equalTo: drawStackView.topAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            drawStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            drawStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            drawStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}

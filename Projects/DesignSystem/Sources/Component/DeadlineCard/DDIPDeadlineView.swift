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
    private let CTAButton = DDIPCTAButton(style: .init(buttonColor: .blue, titleColor: .white, title: "지금 당장 응모할게요!"))
    
    public let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
                                    
        return stackView
    }()
    
    public var viwerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    public let imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public let expirationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public let dashedLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    public init(frame: CGRect = .zero, style: DDIPDeadlineViewStyle) {
        self.style = style
        super.init(frame: frame)
        viwerLabel.addSubview(DDIPListViewer(viewLabel: style.viwer))
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 12
        
        setViews()
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        self.addSubViews([timeStackView, imageIcon, viwerLabel, CTAButton, infoStackView, dashedLine])
        infoStackView.addArrangedSubview(brandLabel)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(expirationLabel)
        
        timeStackView.addArrangedSubview(firstTimeLabel)
        timeStackView.addArrangedSubview(secondTimeLabel)
        timeStackView.addArrangedSubview(separatorLabel)
        timeStackView.addArrangedSubview(firstMinuteLabel)
        timeStackView.addArrangedSubview(secondMinuteLabel)
        
        imageIcon.image = UIImage(systemName: style.iconImage)
        nameLabel.text = style.name
        brandLabel.text = style.brand
        expirationLabel.text = style.expirationDate
        viwerLabel.text = style.viwer
        
        firstTimeLabel.text = style.time
        secondTimeLabel.text = style.time
        firstMinuteLabel.text = style.time
        secondMinuteLabel.text = style.time
        dashedLine.makeDashedBorderLine(color: .black, strokeLength: 10, gapLength: 5, width: 1)
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
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoStackView.topAnchor.constraint(equalTo: dashedLine.bottomAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: viwerLabel.leadingAnchor, constant: -28),
            infoStackView.bottomAnchor.constraint(equalTo: CTAButton.topAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            viwerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            viwerLabel.bottomAnchor.constraint(equalTo: CTAButton.topAnchor, constant: -54),
            viwerLabel.topAnchor.constraint(equalTo: infoStackView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            CTAButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            CTAButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            CTAButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
        ])
    }
}

extension UIView {
    func makeDashedBorderLine(color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineDashPattern = [strokeLength, gapLength]
    
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.midY),
                                CGPoint(x: bounds.maxX, y: bounds.midY)])
        
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

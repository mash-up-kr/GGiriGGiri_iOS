//
//  DDIPListCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/17.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPListCardView: UIView, AddViewsable {
    public enum ApplyStatus {
        case apply
        case progress
        case complete
        
        func choose(style: DDIPListCardViewStyle) -> DDipListCardApplyBaseView {
            switch self {
            case .apply:
                return  DDipListCardDeadlineView(style: style)
            case .progress:
                return DDipListCardApplyView(style: style)
            case .complete:
                return DDipListCardCompleteView(style: style)
            }
        }
    }
    
    public let style: DDIPListCardViewStyle
    private let applyViewer: DDIPApplyViewer
    private let applyStatus: ApplyStatus
    public let nameLabel = UILabel()
    public let brandLabel = UILabel()
    public let expirationLabel = UILabel()
    public let imageIcon = UIImageView()
    private let dashedLine = DashedLine()
    
    public let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    public lazy var drawStackView: DDipListCardApplyBaseView = {
        let stackView = applyStatus.choose(style: style)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
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
    
    public init(
        frame: CGRect = .zero,
        style: DDIPListCardViewStyle,
        applyStatus: ApplyStatus,
        applyViewer: DDIPApplyViewer
    ) {
        self.style = style
        self.applyStatus = applyStatus
        self.applyViewer = applyViewer
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        setView()
        setUI()
        setValue()
        setFont()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        applyViewer.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([infoStackView, imageIcon, applyViewer, semiCircleSpaceLeftView, semiCircleSpaceRightView, dashedLine, drawStackView])
        infoStackView.addArrangedSubviews(brandLabel, nameLabel, expirationLabel)
    }
    
    private func setValue() {
        self.backgroundColor = .designSystem(.neutralWhite)
        brandLabel.text = style.brand
        nameLabel.text = style.name
        expirationLabel.text = "유효기간 : " + style.expirationDate
        imageIcon.image = UIImage(systemName: style.iconImage)
    }
    
    private func setAttribute() {
        brandLabel.textColor = .designSystem(.neutralBlack)
        nameLabel.textColor = .designSystem(.neutralBlack)
        expirationLabel.textColor = .designSystem(.neutralGray500)
    }
    
    private func setFont() {
        brandLabel.font = .designSystem(.pretendard, family: .bold, size: ._12)
        nameLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        expirationLabel.font = .designSystem(.pretendard, family: .bold, size: ._12)
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
            imageIcon.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -11),
            imageIcon.widthAnchor.constraint(equalToConstant: 75),
            imageIcon.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            applyViewer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            applyViewer.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            applyViewer.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -68)
        ])
        
        NSLayoutConstraint.activate([
            dashedLine.heightAnchor.constraint(equalToConstant: 1),
            dashedLine.leadingAnchor.constraint(equalTo: self.semiCircleSpaceLeftView.trailingAnchor),
            dashedLine.trailingAnchor.constraint(equalTo: self.semiCircleSpaceRightView.leadingAnchor),
            dashedLine.bottomAnchor.constraint(equalTo: drawStackView.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            semiCircleSpaceLeftView.heightAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceLeftView.widthAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceLeftView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -9),
            semiCircleSpaceLeftView.centerYAnchor.constraint(equalTo: self.dashedLine.centerYAnchor),
            
            semiCircleSpaceRightView.heightAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceRightView.widthAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceRightView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 9),
            semiCircleSpaceRightView.centerYAnchor.constraint(equalTo: self.dashedLine.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            drawStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            drawStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            drawStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}

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
        
        func choose() -> DDipListCardApplyBaseView {
            switch self {
            case .apply:
                return DDipListCardDeadlineView()
            case .progress:
                return DDipListCardApplyView()
            case .complete:
                return DDipListCardCompleteView()
            }
        }
    }

    public enum ApplyTitleStatus: String {
        case complete = "마감"
        case result = "결과"
        case empty = ""

        var description: String {
            return self.rawValue
        }
    }

    public let applyStatus: ApplyStatus
    private let applyViewer = DDIPApplyViewer()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let expirationLabel = UILabel()
    private let imageIcon = UIImageView()
    private let dashedLine = DashedLine()
    public var applyTitleStatus: ApplyTitleStatus = .empty

    public let productStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()

    public func setListCardDeadlineView(buttonColor: UIColor?, isHidden: Bool, buttonTitle: DDIPCardListButton.TitleStatus, titleStatus: ApplyTitleStatus, leftTime: String) {
        guard let listCardDeadlineView = drawStackView as? DDipListCardDeadlineView else { return }

        listCardDeadlineView.setListCardButton(buttonTitle: buttonTitle, buttonColor: buttonColor, isHidden: isHidden)

        listCardDeadlineView.setDrawLabel(titleStatus: titleStatus.rawValue, leftTime: leftTime)
    }

    public func setListCardCompleteView(drawDate: String) {
        guard let listCardCompleteView = drawStackView as? DDipListCardCompleteView else { return }

        listCardCompleteView.setDrawLabel(drawDate: drawDate)
    }

    public func setListCardApplyView(applyDate: String) {
        guard let listCardApplyView = drawStackView as? DDipListCardApplyView else { return }

        listCardApplyView.setDrawLabel(applyDate: applyDate)
    }

    public func setApplyTitleStatus(applyTitleStatus: ApplyTitleStatus) {
        self.applyTitleStatus = applyTitleStatus
    }

    public func setBrandName(brand: String) {
        brandLabel.text = brand
    }

    public func setName(name: String) {
        nameLabel.text = name
    }

    public func setExpirationDate(expirationDate: String) {
        expirationLabel.text = "유효기간 : \(expirationDate)"
    }

    public func setImageIcon(image: DDIPAsset.name) {
        imageIcon.image = .designSystem(image)
    }

    public func setApplyViewer(viewer: String) {
        applyViewer.setViewer(viewer: viewer)
    }

    public lazy var drawStackView: DDipListCardApplyBaseView = {
        let stackView = applyStatus.choose()
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
        _ applyStatus: ApplyStatus
    ) {
        self.applyStatus = applyStatus
        super.init(frame: frame)
        setView()
        setUI()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.backgroundColor = .designSystem(.neutralWhite)
        self.layer.cornerRadius = 8
        applyViewer.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([productStackView, imageIcon, applyViewer, semiCircleSpaceLeftView, semiCircleSpaceRightView, dashedLine, drawStackView])
        productStackView.addArrangedSubviews(brandLabel, nameLabel, expirationLabel)
    }
    
    private func setAttribute() {
        brandLabel.textColor = .designSystem(.neutralBlack)
        nameLabel.textColor = .designSystem(.neutralBlack)
        expirationLabel.textColor = .designSystem(.neutralGray500)

        brandLabel.font = .designSystem(.pretendard, family: .bold, size: ._12)
        nameLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        expirationLabel.font = .designSystem(.pretendard, family: .bold, size: ._12)
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            productStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            productStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            productStackView.trailingAnchor.constraint(equalTo: imageIcon.leadingAnchor, constant: -17),
            productStackView.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -16)
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

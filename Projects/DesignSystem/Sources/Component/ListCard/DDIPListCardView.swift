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

    public enum RegisterStatus: String {
        case apply = "응모 진행 중"
        case complete = "전달 완료"
        case nobody = "받은 사람 없음"
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
    
    public let drawStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private let applyViewComponent: DDipListCardDeadlineView = {
        let view = DDipListCardDeadlineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let progressViewComponent: DDipListCardApplyView = {
        let view = DDipListCardApplyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let completeViewCmponent: DDipListCardCompleteView = {
        let view = DDipListCardCompleteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public init(_ applyStatus: ApplyStatus) {
        self.applyStatus = applyStatus
        super.init(frame: .zero)
        setView()
        setUI()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        applyViewer.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([
            productStackView,
            imageIcon,
            applyViewer,
            dashedLine,
            semiCircleSpaceLeftView, semiCircleSpaceRightView,
            drawStackView
        ])
        productStackView.addArrangedSubviews(
            brandLabel,
            nameLabel,
            expirationLabel
        )
        drawStackView.addArrangedSubviews(
            applyViewComponent,
            progressViewComponent,
            completeViewCmponent
        )
    }
    
    private func setAttribute() {
        self.backgroundColor = .designSystem(.neutralWhite)
        self.layer.cornerRadius = 8

        brandLabel.textColor = .designSystem(.neutralBlack)
        nameLabel.textColor = .designSystem(.neutralBlack)
        expirationLabel.textColor = .designSystem(.neutralGray500)

        brandLabel.font = .designSystem(.pretendard, family: .medium, size: ._12)
        nameLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        expirationLabel.font = .designSystem(.pretendard, family: .regular, size: ._12)
        
        updateFromApplyStatus()
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            productStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            productStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            productStackView.trailingAnchor.constraint(equalTo: imageIcon.leadingAnchor, constant: -17)
        ])
        
        NSLayoutConstraint.activate([
            imageIcon.widthAnchor.constraint(equalToConstant: 75),
            imageIcon.heightAnchor.constraint(equalToConstant: 75),
            
            imageIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            imageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55)
        ])
        
        NSLayoutConstraint.activate([
            applyViewer.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            applyViewer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            dashedLine.heightAnchor.constraint(equalToConstant: 1),
            
            dashedLine.leadingAnchor.constraint(equalTo: self.semiCircleSpaceLeftView.trailingAnchor),
            dashedLine.trailingAnchor.constraint(equalTo: self.semiCircleSpaceRightView.leadingAnchor),
            dashedLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -82)
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
            drawStackView.topAnchor.constraint(equalTo: productStackView.bottomAnchor, constant: 42),
            drawStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            drawStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            drawStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
    
    private func updateFromApplyStatus() {
        switch applyStatus {
        case .apply:
            applyViewComponent.isHidden = false
            progressViewComponent.isHidden = true
            completeViewCmponent.isHidden = true
        case .progress:
            applyViewComponent.isHidden = true
            progressViewComponent.isHidden = false
            completeViewCmponent.isHidden = true
        case .complete:
            applyViewComponent.isHidden = true
            progressViewComponent.isHidden = true
            completeViewCmponent.isHidden = false
        }
    }
}

// MARK: - 외부 주입 메서드

extension DDIPListCardView {
    public func setListCardDeadlineView(buttonColor: DDIPColor, isHidden: Bool, buttonTitle: DDIPCardListButton.TitleStatus, titleStatus: ApplyTitleStatus, leftTime: Date) {
        guard let listCardDeadlineView = drawStackView as? DDipListCardDeadlineView else { return }

        listCardDeadlineView.setListCardButton(buttonTitle: buttonTitle, buttonColor: buttonColor, isHidden: isHidden, isEnabled: true)

        listCardDeadlineView.setDrawLabel(titleStatus: titleStatus.rawValue, leftTime: leftTime)
    }

    public func setListCardCompleteView(drawDate: Date? = nil, registerStatus: RegisterStatus) {
        guard let listCardCompleteView = drawStackView as? DDipListCardCompleteView else { return }

        listCardCompleteView.setDrawLabel(drawDate: drawDate, registerStatus: registerStatus.rawValue)
    }

    public func setListCardApplyView(applyDate: Date) {
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

    public func setExpirationDate(expirationDate: Date) {
        expirationLabel.text = "유효기간 : \(expirationDate.fullDateString())"
    }

    public func setImageIcon(image: DDIPAsset.name) {
        imageIcon.image = .designSystem(image)
    }

    public func setApplyViewer(viewer: Int) {
        applyViewer.setViewer(viewer: viewer)
    }
}

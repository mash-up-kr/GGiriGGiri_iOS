//
//  DDIPToastView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPToastView: UIView, AddViewsable {
    public enum ToastViewOptions {
        case save, saveFail, register, registerFail, apply, applyMyGifticonFail, networkFail

        var info: (title: String, description: String) {
            switch self {
            case .save:
                return ("저장 완료!", "기프티콘이 갤러리에 저장되었어요.")
            // TODO: - 서버 메시지 주입으로 변경 후 제거해야할 case
            case .saveFail:
                return ("저장 실패", "다시 한 번 시도해주세요.")
            case .register:
                return ("등록 완료", "뿌리기 등록이 완료되었어요!\n 설정한 마감 시간이 지나면 자동적으로 기프티콘이 전달됩니다.")
            // TODO: - 서버 메시지 주입으로 변경 후 제거해야할 case
            case .registerFail:
                return ("등록 실패", "다시 한 번 시도해주세요.")
            case .apply:
                return ("응모 완료", "응모가 완료되었어요!\n 응모 결과는 마감 후에 확인할 수 있어요.")
            // TODO: - 서버 메시지 주입으로 변경 후 제거해야할 case
            case .applyMyGifticonFail:
                return ("응모 실패", "내가 등록한 기프티콘에는\n 응모할 수 없어요!")
            case .networkFail:
                return ("네트워크 실패", "네트워크 에러가 발생했습니다!")
            }
        }
    }
    
    public let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .designSystem(.neutralBlack)
        titleLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        
        return titleLabel
    }()
    
    public let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconImageView
    }()
    
    public let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .designSystem(.neutralGray400)
        descriptionLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
        
        return descriptionLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        super.init(frame: .zero)
        setView()
        setAttribute()
    }

    private func setView() {
        self.addSubViews([titleLabel, iconImageView, descriptionLabel])
        
        setLayout()
    }

    private func setAttribute() {
        self.backgroundColor = .designSystem(.neutralWhite)
        self.layer.cornerRadius = 12
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            titleLabel.bottomAnchor.constraint(equalTo: self.iconImageView.topAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -16),
            iconImageView.widthAnchor.constraint(equalToConstant: 128),
            iconImageView.heightAnchor.constraint(equalToConstant: 128),
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -28)
        ])
    }
}

// MARK: - 외부 주입 메서드

extension DDIPToastView {
    public func setTitleLabel(_ title: ToastViewOptions) {
        titleLabel.text = title.info.title
    }

    public func setTitleLabel(_ title: String) {
        titleLabel.text = title
    }

    public func setIconImageView(_ image: DDIPAsset.name) {
        self.iconImageView.image = .designSystem(image)
    }

    public func setDescriptionLabel(_ description: ToastViewOptions) {
        descriptionLabel.text = description.info.description
    }

    public func setDescriptionLabel(_ description: String) {
        descriptionLabel.text = description
    }
}

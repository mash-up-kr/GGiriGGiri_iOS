//
//  DDIPToastView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

public class DDIPToastView: UIView, AddViewsable {
    public enum ToastType {
        case result
        case imageCheck
    }

    private let type: ToastType

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
        titleLabel.textColor = .designSystem(.neutralBlack)
        titleLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        
        return titleLabel
    }()
    
    public let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        
        return iconImageView
    }()
    
    public let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .designSystem(.neutralGray400)
        descriptionLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
        
        return descriptionLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(_ toastType: ToastType) {
        self.type = toastType
        super.init(frame: .zero)
        setView()
        setAttribute()
        updateFromToastStatus()
    }

    private func updateFromToastStatus() {
        switch type {
        case .result:
            titleLabel.isHidden = false
            iconImageView.isHidden = false
            descriptionLabel.isHidden = false
        case .imageCheck:
            titleLabel.removeFromSuperview()
            iconImageView.removeFromSuperview()
            descriptionLabel.isHidden = false

        }
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
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().inset(0)
            $0.trailing.lessThanOrEqualToSuperview().inset(0)
            $0.top.equalToSuperview().inset(28)
            $0.bottom.equalTo(iconImageView.snp.top).offset(-16)
            $0.height.equalTo(24)
        }

        iconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(descriptionLabel.snp.top).inset(-16)
            $0.width.height.equalTo(128)
        }

        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(28)
        }
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

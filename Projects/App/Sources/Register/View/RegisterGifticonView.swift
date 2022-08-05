//
//  RegisterGifticonView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 정보 등록 화면
final class RegisterGifticonView: BaseView {
    private(set) var registerGiftionImageView = RegisterGiftionImageView()
    private let infoMessageView = InfoMessageView()
    private let registerGifticonInfoView = RegisterGifticonInfoView()
    private let registerGifticonDDipInfoView = RegisterGifticonDDipInfoView()
    
    var showTimeSelectPicker: (() -> ())?
    
    override func setLayout() {
        super.setLayout()
        addSubviews(with: [registerGiftionImageView,
                           infoMessageView,
                           registerGifticonInfoView,
                           registerGifticonDDipInfoView])
        
        
        registerGiftionImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(294)
        }
        
        infoMessageView.snp.makeConstraints {
            $0.top.equalTo(registerGiftionImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        registerGifticonInfoView.snp.makeConstraints {
            $0.top.equalTo(infoMessageView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(infoMessageView)
        }
        
        registerGifticonDDipInfoView.snp.makeConstraints {
            $0.top.equalTo(registerGifticonInfoView.snp.bottom).offset(48)
            $0.leading.trailing.equalTo(infoMessageView)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        registerGifticonDDipInfoView.didTapTimeSelect = { [weak self] in
            self?.showTimeSelectPicker?()
        }
    }
}

extension RegisterGifticonView {
    func updateTime(_ time: String) {
        registerGifticonDDipInfoView.update(time: time)
    }
}


fileprivate class InfoMessageView: BaseView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "😲 중요해요!"
        label.font = .designSystem(.pretendard, family: .bold, size: ._16)
        label.textColor = .designSystem(.neutralBlack)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "등록해주신 기프티콘 이미지는 당첨자에게 전송될 때 사용되며, 등록 시 화면에는 카테고리 아이콘으로 대체됩니다. 미사용 기프티콘인지 다시 한번 확인해주세요."
        label.font = .designSystem(.pretendard, family: .regular, size: ._12)
        label.textColor = .designSystem(.neutralGray500)
        label.numberOfLines = .zero
        return label
    }()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [titleLabel, infoLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func configure() {
        super.configure()
        
        self.layer.cornerRadius = 8
        backgroundColor = .yellow
    }
}


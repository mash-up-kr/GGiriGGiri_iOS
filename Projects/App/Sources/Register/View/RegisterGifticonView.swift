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
    private let gifticonImageView = RegisterGiftionImageView()
    private let infoMessageView = InfoMessageView()
    private let gifticonInfoView = RegisterGifticonInfoView()
    private let ddipInfoView = RegisterGifticonDDipInfoView()
    
    var showTimeSelectPicker: (() -> ())?
    var selectedCategoryIndex: ((Int) -> ())?
    var updateBarandName: ((String?) -> ())?
    var updateProductName: ((String?) -> ())?
    var updateExpirationDate: ((String?) -> ())?
    var updateDeadLineMinute: ((String?) -> ())?
    
    override func setLayout() {
        super.setLayout()
        addSubviews(with: [gifticonImageView,
                           infoMessageView,
                           gifticonInfoView,
                           ddipInfoView])
        
        
        gifticonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(294)
        }
        
        infoMessageView.snp.makeConstraints {
            $0.top.equalTo(gifticonImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        gifticonInfoView.snp.makeConstraints {
            $0.top.equalTo(infoMessageView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(infoMessageView)
        }
        
        ddipInfoView.snp.makeConstraints {
            $0.top.equalTo(gifticonInfoView.snp.bottom).offset(48)
            $0.leading.trailing.equalTo(infoMessageView)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        ddipInfoView.didTapTimeSelect = { [weak self] in
            self?.showTimeSelectPicker?()
        }
        
        gifticonInfoView.didSelectCategory = { [weak self] in
            self?.selectedCategoryIndex?($0)
        }
        
        gifticonInfoView.didUpdateBrandName = { [weak self] in
            self?.updateBarandName?($0)
        }
        
        gifticonInfoView.didUpdateProductName = { [weak self] in
            self?.updateProductName?($0)
        }
        
        gifticonInfoView.didUpdateExpirationDate = { [weak self] in
            self?.updateExpirationDate?($0)
        }
        
        ddipInfoView.didUpdateDeadLineMinute = { [weak self] in
            self?.updateDeadLineMinute?($0)
        }
    }
}

extension RegisterGifticonView {
    func updateTime(_ time: String) {
        ddipInfoView.update(time: time)
    }
    
    func updateCategories(_ categories: [Category]) {
        gifticonInfoView.updateCategoryDataSource(categories)
    }
    
    func updateGifticonImage(_ image: UIImage) {
        gifticonImageView.imageView.image = image
    }
    
    func originalImageDelegate(_ delegate: RegisterGifticonImageViewButtonDelegate) {
        gifticonImageView.delegate = delegate
    }
    
    func updateInformation(_ information: SprinkleInformation) {
        gifticonInfoView.update(brandName: information.brandName)
        gifticonInfoView.update(productName: information.productName)
        gifticonInfoView.update(expirationDate: information.expirationDate)
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

        let categoryText = "카테고리 캐릭터"
        let warningText = "미사용 기프티콘인지 다시 한번 확인해주세요."
        let fullText = "등록해주신 기프티콘 이미지는 당첨자에게 전송될 때 사용되며, 등록 시 화면에는 \(categoryText)로 대체됩니다. \(warningText)"

        let attributedString = NSMutableAttributedString(string: fullText)

        attributedString.setAttributes([
            .font: UIFont.designSystem(.pretendard, family: .regular, size: ._12),
            .foregroundColor: UIColor.designSystem(.neutralGray500)

        ], range: NSString(string: fullText).range(of: fullText))

        attributedString.setAttributes([
            .font: UIFont.designSystem(.pretendard, family: .bold, size: ._12),
            .foregroundColor: UIColor.designSystem(.neutralGray500)
        ], range: NSString(string: fullText).range(of: categoryText))

        attributedString.setAttributes([
            .font: UIFont.designSystem(.pretendard, family: .bold, size: ._12),
            .foregroundColor: UIColor.designSystem(.neutralGray500)
        ], range: NSString(string: fullText).range(of: warningText))

        label.attributedText = attributedString
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
        backgroundColor = .designSystem(.secondaryYellow)
    }
}


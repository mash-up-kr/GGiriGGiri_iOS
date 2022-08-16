//
//  WinView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class WinView: BaseView {

    private let winMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "🎉 당첨을 축하해요!"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._20)
        return label
    }()
    
    private(set) var iconView = GifticonIconView()
    
    private let infoWrapperView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .designSystem(.neutralGray100)
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 27
        return stackView
    }()
    
    private let brandWrapperView = TitleDescriptionView()
    private let productWrapperView = TitleDescriptionView()
    private let expirationDateWrapperView = TitleDescriptionView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "갤러리에 저장 후 기프티콘을 확인하세요!"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._14)
        return label
    }()
    
    override func setLayout() {
        super.setLayout()
        
        verticalStackView.addArrangedSubviews(with: [brandWrapperView,
                                                     productWrapperView,
                                                     expirationDateWrapperView])
        infoWrapperView.addSubview(verticalStackView)
        addSubviews(with: [winMessageLabel,
                           iconView,
                           infoWrapperView,
                           descriptionLabel])
        
        
        winMessageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.top.equalTo(winMessageLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        
        infoWrapperView.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(infoWrapperView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        
        backgroundColor = .clear
        
        iconView.layer.cornerRadius = 15
        infoWrapperView.layer.cornerRadius = 12
    }
    
    func configure(gifticon: Gifticon) {
        brandWrapperView.configure(title: "브랜드", info: gifticon.brand)
        productWrapperView.configure(title: "제품명", info: gifticon.name)
        expirationDateWrapperView.configure(title: "유효기간", info: gifticon.expirationDate)
        iconView.imageView.image = .designSystem(gifticon.rotateImageName) // TODO: develop에 있는 standardImageName으로 변경해야함
    }
}

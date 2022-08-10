//
//  ApplyGifticonInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/27.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 응모 뷰 > 기프티콘 정보 뷰
final class ApplyGifticonInfoView: BaseView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기프티콘 정보"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._18)
        return label
    }()
    
    private let infoContainerView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .designSystem(.neutralGray100)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 27
        return stackView
    }()
    
    private let categoryLabelView = ApplyInformationLabelView("카테고리")
    private let brandLabelView = ApplyInformationLabelView("브랜드")
    private let productNameLabelView = ApplyInformationLabelView("제품명")
    private let expirationDateLabelView = ApplyInformationLabelView("유효기간")
    
    override func setLayout() {
        super.setLayout()
        addSubviews(with: [titleLabel, infoContainerView])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        infoContainerView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        verticalStackView.addArrangedSubviews(with: [
            categoryLabelView,
            brandLabelView,
            productNameLabelView,
            expirationDateLabelView
        ])
    }

    func setCategoryLabelView(_ name: String) {
        categoryLabelView.configure(name: name)
    }

    func setBrandLabelView(_ name: String) {
        brandLabelView.configure(name: name)
    }

    func setProductNameLabelView(_ name: String) {
        productNameLabelView.configure(name: name)
    }

    func setExpirationDateLabelView(_ name: String) {
        expirationDateLabelView.configure(name: name)
    }
}

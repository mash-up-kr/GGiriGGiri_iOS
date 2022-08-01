//
//  ApplyGifticonDDipInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/27.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 응모 뷰 > 뿌리기 정보 뷰
final class ApplyGifticonDDipInfoView: BaseView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "뿌리기 정보"
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
    
    private let participantsLabelView = ApplyInformationLabelView("현재 참여자")
    
    override func setLayout() {
        super.setLayout()
        addSubviews(with: [titleLabel, infoContainerView])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        infoContainerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(participantsLabelView)
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    override func configure() {
        super.configure()
        participantsLabelView.configure(information: "24명")
    }
}

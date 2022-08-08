//
//  RegisterGifticonDDipInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 정보 - 기프티콘 뿌리기 정보 뷰
final class RegisterGifticonDDipInfoView: BaseView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "뿌리기 정보"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._16)
        return label
    }()
    
    private lazy var timeInputView = DDIPInputView(
        inputType: .custom(action: { [weak self] in
            self?.didTapTimeSelect?()
        }),
        title: "마감시간",
        placeholder: "마감시간을 선택해주세요"
    )
    
    var didTapTimeSelect: (() -> ())?
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [titleLabel, timeInputView])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        timeInputView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension RegisterGifticonDDipInfoView {
    func update(time: String) {
        timeInputView.update(text: time)
    }
}

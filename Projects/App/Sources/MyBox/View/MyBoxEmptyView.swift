//
//  MyBoxEmptyView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class MyBoxEmptyView: BaseView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: 빈 화면이라는 이미지 뷰 표시 필요
        imageView.image = UIImage(systemName: "pencil")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleMessage = TempLabel(
        color: .designSystem(.neutralGray400),
        text: "응모한 내역이 없어요",
        font: .designSystem(.pretendard, family: .bold, size: ._18)
    )
    
    private let detailMessage = TempLabel(
        color: .designSystem(.neutralGray400),
        text: "지금 바로 무료 기프티콘에\n응모해보세요!",
        font: .designSystem(.pretendard, family: .regular, size: ._16)
    )
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [imageView, titleMessage, detailMessage])
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(120)
            $0.centerX.equalToSuperview()
        }
        
        titleMessage.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        detailMessage.snp.makeConstraints {
            $0.top.equalTo(titleMessage.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        
        backgroundColor = .clear
        
        titleMessage.textAlignment = .center
        detailMessage.textAlignment = .center
    }
    
    func configureEmptyCategory(with category: MyBox) {
        if category == MyBox.apply {
            titleMessage.text = "응모한 내역이 없어요"
            detailMessage.text = "지금 바로 무료 기프티콘에\n응모해보세요!"
            return
        }
        titleMessage.text = "등록한 내역이 없어요"
        detailMessage.text = "필요없는 기프티콘이 있다면\n지금 바로 등록해볼까요?"
    }
}

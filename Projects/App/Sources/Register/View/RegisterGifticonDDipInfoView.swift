//
//  RegisterGifticonDDipInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class RegisterGifticonDDipInfoView: BaseView {
    
    private let titleLabel = TempLabel(color: .black,
                                       text: "뿌리기 정보",
                                       font: .systemFont(ofSize: 16))
    override func setLayout() {
        super.setLayout()
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .yellow
    }
}

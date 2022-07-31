//
//  ApplyBoxView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class ApplyBoxView: BaseView {

    private let emptyView = MyBoxEmptyView()
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(emptyView)
        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(117)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(302)
        }
    }

    override func configure() {
        super.configure()
        
        backgroundColor = .clear
        
        emptyView.configureEmptyCategory(with: .apply)
    }
}

//
//  GifticonListEmptyView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/19.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class GifticonListEmptyView: BaseView {

    private let emptyView = EmptyView()
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(emptyView)
        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(302)
        }
    }

    override func configure() {
        super.configure()
        
        backgroundColor = .clear
        
        emptyView.configureEmptyCategory()
    }
}

//
//  CommonHeaderView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import SnapKit
import UIKit

final class CommonHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "CommonHeaderView"
    
    let titleLabel = TempLabel(color: .black,
                               font: .systemFont(ofSize: 16,
                                                 weight: .bold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.top.equalTo(self.snp.top).offset(14)
            $0.bottom.equalTo(self.snp.bottom).offset(-24)
        }
    }
}

//
//  BaseHeaderView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class BaseHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "BaseHeaderView"
    
    private(set) var titleLabel = TempLabel(color: .black,
                               font: .systemFont(ofSize: 16,
                                                 weight: .bold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.top.equalTo(self.snp.top).offset(14)
            $0.bottom.equalTo(self.snp.bottom).offset(-24)
        }
    }
}

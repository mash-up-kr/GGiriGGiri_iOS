//
//  CommonHeaderView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class CommonHeaderView: UICollectionReusableView {
    
    let titleLabel = TempLabel(color: .black,
                               font: .systemFont(ofSize: 22,
                                                 weight: .medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        
        let inset = CGFloat(16)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(inset)
            $0.trailing.equalTo(-inset)
            $0.top.equalTo(self.snp.top).inset(inset * 1.1)
            $0.bottom.equalTo(self.snp.bottom).inset(inset * 0.4)
        }
    }
}

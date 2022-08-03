//
//  MyBoxListCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class MyBoxListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MyBoxListCollectionViewCell"
    
    var myBoxType: MyBox = .register
    
    private var listCardView = DDIPListCardView(.apply)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
        configure()
    }
    
    private func setLayout() {
        contentView.addSubview(listCardView)
        
        listCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(7)
        }
    }
    
    private func configure() {
        backgroundColor = .clear
    }
    
    func configure(with category: MyBox, data: GifticonCard) { }
}

//
//  CategoryCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    private let nameLabel = TempLabel(color: .black, font: UIFont.pretendard(family: .regular, size: ._14))
    
    func configure(_ category: [Category], with index: Int) {
        nameLabel.textAlignment = .center
        nameLabel.clipsToBounds = true
        
        if category == Category.register {
            nameLabel.text = Category.register[index].rawValue
            return
        }
        nameLabel.text = Category.allCases[index].rawValue
    }
    
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
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(7)
        }
    }
    
    private func configure() {
        backgroundColor = .white
        
        self.layer.cornerRadius = 20
    }
}

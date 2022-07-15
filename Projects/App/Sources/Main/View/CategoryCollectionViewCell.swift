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
    
    private let nameLabel = TempLabel(color: .black)
    
    func configure(with index: Int) {
        nameLabel.textAlignment = .center
        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 20
        nameLabel.text = Category.allCases[index].rawValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

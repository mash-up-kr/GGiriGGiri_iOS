//
//  CategoryCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let nameLabel = TempLabel(color: .black)
    
    func configure(with index: Int) {
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .yellow
        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 20
        nameLabel.text = CategoryList.allCases[index].rawValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        contentView.backgroundColor = .white
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//
//  CategoryCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    private let categoryButton = DDIPCategoryButton()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryButton.setButtonTitle("")
        categoryButton.isSelected = false
    }
    
    private func setLayout() {
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configure() {
        categoryButton.isUserInteractionEnabled = false
        categoryButton.setHeight(.height_34)
        self.layer.cornerRadius = 17
        self.clipsToBounds = true
    }
    
    func configure(_ category: Category, isAlreadySelected: Bool = false) {
        update(categoryButtonTitle: category.description)
        updateButton(isSelected: isAlreadySelected)
    }
    
    private func update(categoryButtonTitle: String) {
        categoryButton.setButtonTitle(categoryButtonTitle)
    }
    
    func updateButton(isSelected: Bool) {
        categoryButton.isSelected = isSelected
    }
}

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
    
    private(set) var categoryType: Category = .all
    private let nameLabel = TempLabel(
        color: .black,
        font: .designSystem(.pretendard, family: .regular, size: ._14)
    )
    
    private let categoryButton = DDIPCategoryButton(
        style: .init(
            buttonColor: .designSystem(.neutralWhite) ?? .label,
            titleColor: .designSystem(.neutralBlack) ?? .label,
            title: "버튼타이틀",
            height: .height_34,
            topInset: 7,
            leftInset: 16,
            rightInset: 16,
            bottomInset: 7
        )
    )
    
    func configure(_ category: [Category], with index: Int) {
        nameLabel.textAlignment = .center
        nameLabel.clipsToBounds = true
        
        categoryType = Category.allCases[index]
        
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
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//        contentView.addSubview(nameLabel)
//
//        nameLabel.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.top.bottom.equalToSuperview().inset(7)
//        }
    }
    
    private func configure() {
        
//        backgroundColor = .designSystem(.neutralWhite)
//
//        self.layer.cornerRadius = 20
        categoryButton.isUserInteractionEnabled = false
    }
}

//
//  RegisterGifticonInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class RegisterGifticonInfoView: BaseView {
    
    private let titleLabel = TempLabel(color: .black,
                                       text: "기프티콘 정보",
                                       font: .systemFont(ofSize: 16))
    
    private let categoryLabel = TempLabel(color: .black,
                                          text: "카테고리",
                                          font: .systemFont(ofSize: 14))
    
    private lazy var categoryView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .yellow
        collectionView.register(CategoryCollectionViewCell.self)
        return collectionView
    }()
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return self.generateCategorySection()
        }
        return layout
    }
    
    private func generateCategorySection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .estimated(1),
                                                                    heightDimension: .estimated(1)))
        
        let group = CollectionViewLayoutManager.configureGroup(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .estimated(1)),
                                                               item: item)
        
        let section = CollectionViewLayoutManager.configureSection(with: group,
                                                                   scrollingBehavior: nil,
                                                                   header: nil)
        return section
    }
    
    private let categoryCollectionViewDataSource = CategoryCollectionViewDataSource()
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(categoryView)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(20)
        }
        
        categoryView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(categoryLabel.snp.bottom).offset(16)
            $0.height.equalTo(81)
        }
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .cyan
        
        categoryView.dataSource = categoryCollectionViewDataSource
    }
}

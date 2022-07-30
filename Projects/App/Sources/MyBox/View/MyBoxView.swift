//
//  MyBoxView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class MyBoxView: BaseView {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .designSystem(.primaryYellow)
        collectionView.register(MyBoxCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return self.generateSection()
        }
        return layout
    }
    
    private func generateSection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
        let inset: CGFloat = 16
        item.contentInsets = .init(top: .zero, leading: inset, bottom: .zero, trailing: inset)
        
        let group = CollectionViewLayoutManager.configureGroup(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: item.layoutSize.widthDimension,
                                                                    heightDimension: item.layoutSize.heightDimension),
                                                               item: item)
        
        let section = CollectionViewLayoutManager.configureSection(with: group,
                                                                   scrollingBehavior: .groupPaging,
                                                                   header: nil)
        return section
    }
    
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .clear
    }
    
    func configureDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func configureDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
}

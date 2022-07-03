//
//  MainView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import SnapKit
import UIKit

final class MainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUI()
    }
    
    private func setUI() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .white
        collectionView.register(
            GifticonListCardCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: GifticonListCardCollectionViewCell.self))
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
        collectionView.register(
            GifticonListCardCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: GifticonListCardCollectionViewCell.self))
        collectionView.register(
            CommonHeaderView.self,
            forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
            withReuseIdentifier: String(describing: CommonHeaderView.self))
        return collectionView
    }()
    
    func configureDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = MainSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .deadLine:
                return self.generateDeadLineSection()
            case .category:
                return self.generateCategorySection()
            case .gifticonList:
                return self.generateGifticonListSection()
            }
        }
        return layout
    }
    
    private func generateDeadLineSection() -> NSCollectionLayoutSection {
        let item = LayoutManager.configureItem(with: Size(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .fractionalWidth(2/3)))
        
        let group = LayoutManager.configureGroup(with: Size(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalWidth(2/3)),
                                                 item: item, itemCount: 1)
        
        let header = LayoutManager.configureHeader(with: Size(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .estimated(1)),
                                                   elementKind: MainViewController.sectionHeaderElementKind)
        
        let section = LayoutManager.configureSection(with: group,
                                                     header: header)
        return section
    }
    
    private func generateCategorySection() -> NSCollectionLayoutSection {
        let item = LayoutManager.configureItem(with: Size(widthDimension: .fractionalWidth(0.3),
                                                          heightDimension: .fractionalWidth(0.2)))
        
        let group = LayoutManager.configureGroup(with: Size(widthDimension: .fractionalWidth(0.3),
                                                            heightDimension: .fractionalWidth(0.2)),
                                                 item: item, itemCount: 1)

        
        let header = LayoutManager.configureHeader(with: Size(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .estimated(1)),
                                                   elementKind: MainViewController.sectionHeaderElementKind)
        
        let section = LayoutManager.configureSection(with: group,
                                                     header: header)
        return section
    }
    
    private func generateGifticonListSection() -> NSCollectionLayoutSection {
        let item = LayoutManager.configureItem(with: Size(widthDimension: .absolute(343),
                                                          heightDimension: .absolute(180)),
                                               inset: NSDirectionalEdgeInsets(top: 10,
                                                                                     leading: 10,
                                                                                     bottom: 0,
                                                                                     trailing: 0))
        
        let group = LayoutManager.configureGroup(with: Size(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)),
                                                 isDirectionVertical: true,
                                                 item: item,
                                                 itemCount: 10)
        
        let section = LayoutManager.configureSection(with: group, header: nil)
        return section
    }
}

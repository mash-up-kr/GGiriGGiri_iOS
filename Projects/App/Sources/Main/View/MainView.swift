//
//  MainView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class MainView: BaseView {
    
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(GifticonDeadLineCollectionViewCell.self)
        collectionView.register(CategoryCollectionViewCell.self)
        collectionView.register(GifticonCardCollectionViewCell.self)
        collectionView.registerHeader(BaseHeaderView.self,
                                      elementKind: MainViewController.sectionHeaderElementKind)
        return collectionView
    }()
    
    func configureDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func configureDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
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
        let item = CollectionViewLayoutManager.configureItem(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .absolute(310),
                                                                    heightDimension: .absolute(380)))
        
        let group = CollectionViewLayoutManager.configureGroup(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: item.layoutSize.widthDimension,
                                                                    heightDimension: item.layoutSize.heightDimension),
                                                               edgeSpacing: .init(leading: .fixed(10),
                                                                                  top: .none,
                                                                                  trailing: .none,
                                                                                  bottom: .none),
                                                               item: item)
        
        let header = CollectionViewLayoutManager.configureHeader(with:
                                                                    CollectionViewConfigureSize(
                                                                        widthDimension: .fractionalWidth(1.0),
                                                                        heightDimension: .estimated(1)),
                                                                 elementKind: MainViewController.sectionHeaderElementKind)
        
        let section = CollectionViewLayoutManager.configureSection(with: group,
                                                                   scrollingBehavior: .groupPaging,
                                                                   header: header)
        return section
    }
    
    private func generateCategorySection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .estimated(40),
                                                                    heightDimension: .estimated(14)))
        
        let group = CollectionViewLayoutManager.configureGroup(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .estimated(1),
                                                                    heightDimension: .estimated(1)),
                                                               edgeSpacing: .init(leading: .fixed(8),
                                                                                  top: .none,
                                                                                  trailing: .none,
                                                                                  bottom: .none),
                                                               item: item)

        
        let header = CollectionViewLayoutManager.configureHeader(with:
                                                                    CollectionViewConfigureSize(
                                                                        widthDimension: .fractionalWidth(1.0),
                                                                        heightDimension: .estimated(1)),
                                                                 elementKind: MainViewController.sectionHeaderElementKind)
        
        let section = CollectionViewLayoutManager.configureSection(with: group,
                                                                   scrollingBehavior: .groupPaging,
                                                                   header: header)
        return section
    }
    
    private func generateGifticonListSection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .absolute(343),
                                                                    heightDimension: .absolute(180)))
        
        let group = CollectionViewLayoutManager.configureGroup(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: item.layoutSize.heightDimension),
                                                               edgeSpacing: .init(leading: .fixed(10),
                                                                                  top: .fixed(16),
                                                                                  trailing: .none,
                                                                                  bottom: .none),
                                                               isDirectionVertical: true,
                                                               item: item)
        
        let section = CollectionViewLayoutManager.configureSection(with: group,
                                                                   scrollingBehavior: nil,
                                                                   header: nil)
        return section
    }
}

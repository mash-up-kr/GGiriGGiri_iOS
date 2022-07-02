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
        
        configureDataSource()
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
            CommonHeaderView.self,
            forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
            withReuseIdentifier: String(describing: CommonHeaderView.self))
        return collectionView
    }()
    
    private var dataSource: MainCollectionViewDiffableDataSource!
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = MainSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .deadLine:
                return self.generateDeadLineSection()
            case .category:
                return self.generateCategorySection()
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
    
    private func configureDataSource() {
        dataSource = MainCollectionViewDiffableDataSource(collectionView: collectionView,
                                                          cellProvider: { collectionView, indexPath, itemIdentifier in
            let sectionType = MainSection.allCases[indexPath.section]
            
            switch sectionType {
            case .deadLine:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonListCardCollectionViewCell.self), for: indexPath) as? GifticonListCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(with: GifticonListCardItem(remainingTime: "123초",
                                                          gifticonInfo:
                                                            Gifticon(brand: "스타벅스",
                                                                     name: "아메리카노",
                                                                     expirationDate: "20220626",
                                                                     imageUrl: ""),
                                                          numberOfParticipants: 5,
                                                          isParticipating: false))
                return cell
            case .category:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as? CategoryCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: indexPath.row)
                return cell
            }
        })
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<MainSection, MainItem> {
        var snapshot = NSDiffableDataSourceSnapshot<MainSection, MainItem>()
        snapshot.appendSections([.deadLine, .category])
        snapshot.appendItems(itemsForDeadLineSection(), toSection: .deadLine)
        snapshot.appendItems(itemsForCategorySection(), toSection: .category)
        return snapshot
    }
    
    private func itemsForDeadLineSection() -> [MainItem] {
        return [MainItem(), MainItem(), MainItem()]
    }
    
    private func itemsForCategorySection() -> [MainItem] {
        return [MainItem(), MainItem(), MainItem(), MainItem(), MainItem(), MainItem()]
    }
}

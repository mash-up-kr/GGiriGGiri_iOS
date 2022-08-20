//
//  MyBoxCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class MyBoxCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MyBoxCollectionViewCell"
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .designSystem(.primaryYellow)
        collectionView.register(MyBoxListCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let applyBoxView = ApplyBoxView()
    private let registerBoxView = RegisterBoxView()
    
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
                                                                    widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .absolute(180)))
        
        let group = CollectionViewLayoutManager.configureGroup(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: item.layoutSize.heightDimension),
                                                               edgeSpacing: .init(leading: .none,
                                                                                  top: .fixed(16),
                                                                                  trailing: .none,
                                                                                  bottom: .none),
                                                               isDirectionVertical: true,
                                                               item: item)
        
        let section = CollectionViewLayoutManager.configureSection(with: group,
                                                                   contentInsets: .init(top: .zero,
                                                                                        leading: 16,
                                                                                        bottom: 32,
                                                                                        trailing: 16),
                                                                   scrollingBehavior: nil,
                                                                   header: nil)
        return section
    }
    
    func configureDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func configureDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
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
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configure() {
        backgroundColor = .clear
    }
    
    func configure(with category: MyBox) {
        switch category {
        case .applied:
            collectionView.backgroundView = applyBoxView
        case .registered:
            collectionView.backgroundView = registerBoxView
        }
    }
}


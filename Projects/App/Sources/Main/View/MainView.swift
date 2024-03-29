//
//  MainView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift
import SnapKit

final class MainView: BaseView {
    
    var isDeadlineDataExist = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
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
        
        isDeadlineDataExist
            .skip(1)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.reloadCollectionViewSection(.deadLine)
            })
            .disposed(by: disposeBag)
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(GifticonDeadLineCollectionViewCell.self)
        collectionView.register(CategoryCollectionViewCell.self)
        collectionView.register(GifticonCardCollectionViewCell.self)
        collectionView.registerHeader(
            BaseHeaderView.self,
            elementKind: MainViewController.sectionHeaderElementKind
        )
        collectionView.showsVerticalScrollIndicator = false
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
                if self.isDeadlineDataExist.value {
                    return self.generateDeadlineSection()
                } else {
                    return self.generateEmptySection()
                }
            case .category:
                return self.generateCategorySection()
            case .gifticonList:
                return self.generateGifticonListSection()
            }
        }
        return layout
    }
    
    private func generateEmptySection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(
            with: CollectionViewConfigureSize(
                widthDimension: .absolute(0.00001),
                heightDimension: .absolute(0.00001)
            )
        )
        
        let group = CollectionViewLayoutManager.configureGroup(
            with: CollectionViewConfigureSize(
                widthDimension: .absolute(0.00001),
                heightDimension: .absolute(0.00001)
            ),
            item: item
        )
        
        let section = CollectionViewLayoutManager.configureSection(
            with: group,
            scrollingBehavior: .continuous,
            header: nil
        )
        return section
    }
    
    private func generateDeadlineSection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(
            with: CollectionViewConfigureSize(
                widthDimension: .absolute(310),
                heightDimension: .absolute(380)
            )
        )
        
        let group = CollectionViewLayoutManager.configureGroup(
            with: CollectionViewConfigureSize(
                widthDimension: item.layoutSize.widthDimension,
                heightDimension: item.layoutSize.heightDimension
            ),
            edgeSpacing: .init(
                leading: .none,
                top: .none,
                trailing: .fixed(16),
                bottom: .none
            ),
            item: item
        )
        
        let header = CollectionViewLayoutManager.configureHeader(
            with: CollectionViewConfigureSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(58)
            ),
            elementKind: MainViewController.sectionHeaderElementKind
        )
        
        let section = CollectionViewLayoutManager.configureSection(
            with: group,
            contentInsets: .init(
                top: .zero,
                leading: 16,
                bottom: 26,
                trailing: .zero
            ),
            scrollingBehavior: .groupPaging,
            header: header
        )
        return section
    }
    
    private func generateCategorySection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(
            with: CollectionViewConfigureSize(
                widthDimension: .estimated(57),
                heightDimension: .absolute(34)
            )
        )
        
        let group = CollectionViewLayoutManager.configureGroup(
            with: CollectionViewConfigureSize(
                widthDimension: .estimated(1),
                heightDimension: .estimated(1)
            ),
            edgeSpacing: .init(
                leading: .none,
                top: .none,
                trailing: .fixed(4),
                bottom: .none
            ),
            item: item
        )
        
        let header = CollectionViewLayoutManager.configureHeader(
            with: CollectionViewConfigureSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(58)
            ),
            elementKind: MainViewController.sectionHeaderElementKind
        )
        
        let section = CollectionViewLayoutManager.configureSection(
            with: group,
            contentInsets: .init(
                top: .zero,
                leading: 16,
                bottom: .zero,
                trailing: 8
            ),
            scrollingBehavior: .continuous,
            header: header
        )
        return section
    }
    
    private func generateGifticonListSection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(
            with: CollectionViewConfigureSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(180)
            )
        )
        
        let group = CollectionViewLayoutManager.configureGroup(
            with: CollectionViewConfigureSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: item.layoutSize.heightDimension
            ),
            edgeSpacing: .init(
                leading: .none,
                top: .fixed(16),
                trailing: .none,
                bottom: .none
            ),
            isDirectionVertical: true,
            item: item
        )
        
        let section = CollectionViewLayoutManager.configureSection(
            with: group,
            contentInsets: .init(
                top: .zero,
                leading: 16,
                bottom: .zero,
                trailing: 16
            ),
            scrollingBehavior: nil,
            header: nil
        )
        return section
    }
    
    /// 메인 collectionView 중 필요한 섹션만 리로드
    /// - Parameter section: 리로드할 MainSection Enum
    func reloadCollectionViewSection(_ section: MainSection) {
        collectionView.reloadSections([section.rawValue])
    }
}

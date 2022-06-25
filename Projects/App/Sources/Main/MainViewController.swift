//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import UIKit

class MainViewController: UIViewController {
    
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
     
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var mainCollectionView: UICollectionView! = nil
    private var dataSource: MainCollectionViewDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureNavigationBar() {
        let button = TempBarButton()
        let myButtonItem = UIBarButtonItem(customView: button.myButton)
        let notiButton = UIBarButtonItem(customView: button.notiButton)
        self.navigationItem.rightBarButtonItems = [notiButton, myButtonItem]
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.title = "DDIP"
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.register(
            GifticonListCardCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: GifticonListCardCollectionViewCell.self))
        mainCollectionView = collectionView
    }
    
    private func configureDataSource() {
        dataSource = MainCollectionViewDiffableDataSource(collectionView: mainCollectionView,
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
            }
        })
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<MainSection, MainItem> {
        var snapshot = NSDiffableDataSourceSnapshot<MainSection, MainItem>()
        snapshot.appendSections([MainSection.deadLine])
        snapshot.appendItems(Array(itemsForDeadLineSection().prefix(3)))
        return snapshot
    }
    
    private func itemsForDeadLineSection() -> [MainItem] {
        return [MainItem(title: "하하"), MainItem(title: "호호"), MainItem(title: "헤헤")]
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = MainSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .deadLine:
                return self.generateDeadLineSection()
            }
        }
        return layout
    }
    
    private func generateDeadLineSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        return section
    }
}

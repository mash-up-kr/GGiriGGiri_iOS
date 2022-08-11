//
//  MainCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var deadLineData: [GifticonCard] = []
    private var categoryData: [Category] = []
    private var gifticonListData: [GifticonCard] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MockData.main.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return deadLineData.count
        case 1:
            return categoryData.count
        case 2:
            return gifticonListData.count
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MockData.main[indexPath.section] {
        case .deadLine(let items):
            guard let cell = collectionView.dequeReusableCell(GifticonDeadLineCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            return cell
        case .category(_):
            guard let cell = collectionView.dequeReusableCell(CategoryCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            let category = categoryData[indexPath.row]
            cell.configure(category)
            return cell
        case .gifticonList(let items):
            guard let cell = collectionView.dequeReusableCell(GifticonCardCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: BaseHeaderView.reuseIdentifier,
                                              for: indexPath) as? BaseHeaderView else {
            return UICollectionReusableView()
        }
        supplementaryView.titleLabel.text = MainSection.allCases[indexPath.section].headerTitle
        return supplementaryView
    }
}

extension MainCollectionViewDataSource {
    func updateCategoryData(_ list: [Category]) {
        categoryData = list
    }
}

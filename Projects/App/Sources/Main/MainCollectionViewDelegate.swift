//
//  MainCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol MainCollectionViewCellDelegate: AnyObject {
    func gifticonCellTapped(with id: Int)
    func categoryCellTapped(with category: Category)
}

final class MainCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    weak var collectionViewCellDelegate: MainCollectionViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch MainSection.allCases[indexPath.section] {
        case .deadLine:
            guard let cell = collectionView.cellForItem(at: indexPath) as? GifticonDeadLineCollectionViewCell else {
                return
            }
            collectionViewCellDelegate?.gifticonCellTapped(with: cell.gifticonId)
        case .category:
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {
                return
            }
            collectionViewCellDelegate?.categoryCellTapped(with: cell.categoryType)
        case .gifticonList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? GifticonCardCollectionViewCell else {
                return
            }
            collectionViewCellDelegate?.gifticonCellTapped(with: cell.gifticonId)
        }
    }
}

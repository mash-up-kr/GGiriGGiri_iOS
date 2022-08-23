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
    func categoryCellTapped(indexPath: IndexPath)
}

final class MainCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    weak var collectionViewCellDelegate: MainCollectionViewCellDelegate?
    
    var selectedCategoryIndexPath: IndexPath? = nil
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch MainSection.allCases[indexPath.section] {
        case .deadLine:
            guard let cell = collectionView.cellForItem(at: indexPath) as? GifticonDeadLineCollectionViewCell else {
                return
            }
            collectionViewCellDelegate?.gifticonCellTapped(with: cell.gifticonId)
        case .category:
            // 보여지는 모든 셀의 선택 상태 초기화
            collectionView.visibleCells.forEach { cell in
                guard let cell = cell as? CategoryCollectionViewCell else { return }
                cell.updateButton(isSelected: false)
            }
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {
                return
            }
            
            // 셀 선택 상태 변경
            cell.updateButton(isSelected: true)
            
            guard selectedCategoryIndexPath != indexPath else { return }
            selectedCategoryIndexPath = indexPath
            collectionViewCellDelegate?.categoryCellTapped(indexPath: indexPath)
        case .gifticonList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? GifticonCardCollectionViewCell else {
                return
            }
            collectionViewCellDelegate?.gifticonCellTapped(with: cell.gifticonId)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch MainSection.allCases[indexPath.section] {
        case .deadLine:
            break
        case .category:
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {
                return
            }
            cell.updateButton(isSelected: false)
        case .gifticonList:
            break
        }
    }
}

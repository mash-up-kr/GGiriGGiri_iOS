//
//  MainCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol MainCollectionViewCellDelegate: AnyObject {
    func cellTapped(with indexPath: IndexPath)
}

final class MainCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    weak var collectionViewCellDelegate: MainCollectionViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch MainSection.allCases[indexPath.section] {
        case .deadLine:
            collectionViewCellDelegate?.cellTapped(with: indexPath)
            debugPrint(String(indexPath.section) + String(indexPath.item))
        case .category:
            collectionViewCellDelegate?.cellTapped(with: indexPath)
            debugPrint(String(indexPath.section) + String(indexPath.item))
        case .gifticonList:
            collectionViewCellDelegate?.cellTapped(with: indexPath)
            debugPrint(String(indexPath.section) + String(indexPath.item))
        }
    }
}

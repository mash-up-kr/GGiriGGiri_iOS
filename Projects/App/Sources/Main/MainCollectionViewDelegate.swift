//
//  MainCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MainCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch MainSection.allCases[indexPath.section] {
        case .deadLine:
            debugPrint(String(indexPath.section) + String(indexPath.item))
        case .category:
            debugPrint(String(indexPath.section) + String(indexPath.item))
        case .gifticonList:
            debugPrint(String(indexPath.section) + String(indexPath.item))
        }
    }
}

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
        switch indexPath.section {
        case 0:
            Log.info(String(indexPath.section) + String(indexPath.item))
        case 1:
            Log.info(String(indexPath.section) + String(indexPath.item))
        default:
            Log.info(String(indexPath.section) + String(indexPath.item))
        }
    }
}

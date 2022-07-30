//
//  MyBoxListCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MyBoxListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MyBoxListCollectionViewCell else { return }
        debugPrint("MyBoxListCollectionViewDelegate", indexPath)
    }
}

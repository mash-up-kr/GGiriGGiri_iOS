//
//  MyBoxCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MyBoxCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MyBoxCollectionViewCell else { return }
        debugPrint("MyBoxCollectionViewDelegate", indexPath)
    }
}

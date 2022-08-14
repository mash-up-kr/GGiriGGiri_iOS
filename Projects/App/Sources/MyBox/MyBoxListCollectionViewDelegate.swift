//
//  MyBoxListCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol MyBoxListCollectionViewCellDelegate: AnyObject {
    func cellTapped(type: MyBox, with index: Int)
}

final class MyBoxListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    weak var myBoxListCollectionViewCellDelegate: MyBoxListCollectionViewCellDelegate?
    var type: MyBox
    
    init(type: MyBox) {
        self.type = type
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MyBoxListCollectionViewCell else { return }
        myBoxListCollectionViewCellDelegate?.cellTapped(type: type, with: indexPath.item)
    }
}

//
//  ImageCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol ImageCollectionViewCellDelegate {
    func imageCollectionViewCellDidTapped(itemAt indexPath: IndexPath)
}

final class ImageCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var imageCollectionViewCellDelegate: ImageCollectionViewCellDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageCollectionViewCellDelegate?.imageCollectionViewCellDidTapped(itemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.width / 4)
    }
}


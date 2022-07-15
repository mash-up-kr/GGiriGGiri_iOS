//
//  CategoryCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class CategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeReusableCell(CategoryCollectionViewCell.self,
                                                          for: indexPath) else {
            return UICollectionViewCell()
        }
        
        if indexPath.item == 6 {
            cell.configure(with: indexPath.item - 1)
            return cell
        }
        cell.configure(with: indexPath.item + 1)
        return cell
    }
}

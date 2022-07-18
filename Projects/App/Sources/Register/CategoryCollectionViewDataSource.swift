//
//  CategoryCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class CategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let category = Category.allCases.filter { return $0 != Category.all }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.register.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeReusableCell(CategoryCollectionViewCell.self,
                                                          for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(Category.register, with: indexPath.item)
        return cell
    }
}

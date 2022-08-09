//
//  CategoryCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class CategoryCollectionViewDataSource: NSObject {
    private var category: [String] = []
    
    func update(_ category: [String]) {
        self.category = category
    }
}

extension CategoryCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeReusableCell(CategoryCollectionViewCell.self,
                                                          for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.update(category[indexPath.row])
        return cell
    }
}

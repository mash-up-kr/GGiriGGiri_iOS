//
//  MyBoxListCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MyBoxListCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var item = MockData.myBox
    var currentType: MyBox = .register
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = item.count
        if itemCount != 0 {
            collectionView.backgroundView = nil
        }
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeReusableCell(MyBoxListCollectionViewCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        
        switch currentType {
        case .apply:
            cell.myBoxType = .apply
            cell.configure(with: .apply, data: item[indexPath.item])
        case .register:
            cell.myBoxType = .register
            cell.configure(with: .register, data: item[indexPath.item])
        }
        return cell
    }
}

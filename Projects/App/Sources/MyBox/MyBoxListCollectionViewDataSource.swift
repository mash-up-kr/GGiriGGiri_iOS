//
//  MyBoxListCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol MyBoxListCollectionViewButtonDelegate: AnyObject {
    func resultButtonTapped(with id: Int, result: DrawStatus)
}

final class MyBoxListCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    weak var resultButtonDelegate: MyBoxListCollectionViewButtonDelegate?
    var item = [GifticonCard]()
    var currentType: MyBox = .registered
    
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
        case .applied:
            cell.resultButtonDelegate = self
            cell.configure(with: .applied, data: item[indexPath.item])
        case .registered:
            cell.configure(with: .registered, data: item[indexPath.item])
        }
        return cell
    }
}

extension MyBoxListCollectionViewDataSource: MyBoxListResultButtonDelegate {
    func resultButtonTapped(with id: Int, result: DrawStatus) {
        resultButtonDelegate?.resultButtonTapped(with: id, result: result)
    }
}

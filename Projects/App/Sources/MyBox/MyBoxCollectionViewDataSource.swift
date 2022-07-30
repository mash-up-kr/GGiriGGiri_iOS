//
//  MyBoxCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MyBoxCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let listCollectionViewDataSource = MyBoxListCollectionViewDataSource()
    private let listCollectionViewDelegate = MyBoxListCollectionViewDelegate()
    private let item = MockData.myBox
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeReusableCell(MyBoxCollectionViewCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.configureDataSource(listCollectionViewDataSource)
        cell.configureDelegate(listCollectionViewDelegate)
        
        switch MyBox.allCases[indexPath.item] {
        case .apply:
            listCollectionViewDataSource.currentType = .apply
            cell.configure(with: .apply)
        case .register:
            listCollectionViewDataSource.currentType = .register
            cell.configure(with: .register)
        }
        return cell
    }
}

//
//  MyBoxCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MyBoxCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var item = [[GifticonCard]]()
    
    private let applyDataSource = MyBoxListCollectionViewDataSource()
    private let applyDelegate = MyBoxListCollectionViewDelegate()
    private let registerDatasource = MyBoxListCollectionViewDataSource()
    private let registerDelegate = MyBoxListCollectionViewDelegate()
    
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
        
        switch MyBox.allCases[indexPath.item] {
        case .apply:
            guard let applyItem = item.first else { return UICollectionViewCell() }
            applyDataSource.item = applyItem
            applyDataSource.currentType = .apply
            
            cell.configureDataSource(applyDataSource)
            cell.configureDelegate(applyDelegate)
            cell.configure(with: .apply)
        case .register:
            guard let registerItem = item.last else { return UICollectionViewCell() }
            registerDatasource.item = registerItem
            registerDatasource.currentType = .register
            
            cell.configureDataSource(registerDatasource)
            cell.configureDelegate(registerDelegate)
            cell.configure(with: .register)
        }
        return cell
    }
}

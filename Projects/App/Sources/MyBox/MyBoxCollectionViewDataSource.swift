//
//  MyBoxCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MyBoxCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var item = [[GifticonCard](), [GifticonCard]()]
    
    private(set) var applyDataSource = MyBoxListCollectionViewDataSource()
    private(set) var applyDelegate = MyBoxListCollectionViewDelegate(type: .applied)
    private let registerDatasource = MyBoxListCollectionViewDataSource()
    private(set) var registerDelegate = MyBoxListCollectionViewDelegate(type: .registered)
    
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
        case .applied:
            guard let applyItem = item.first else { return cell }
            applyDataSource.item = applyItem
            applyDataSource.currentType = .applied
            applyDelegate.data = applyItem
            
            cell.configureDataSource(applyDataSource)
            cell.configureDelegate(applyDelegate)
            cell.configure(with: .applied)
        case .registered:
            guard let registerItem = item.last else { return cell }
            registerDatasource.item = registerItem
            registerDatasource.currentType = .registered
            
            cell.configureDataSource(registerDatasource)
            cell.configureDelegate(registerDelegate)
            cell.configure(with: .registered)
        }
        return cell
    }
}

extension MyBoxCollectionViewDataSource {
    func updateApplyList(_ list: [GifticonCard]) {
        if item.count != 0 {
            item[0] = list
        }
    }
    
    func updateRegisterList(_ list: [GifticonCard]) {
        if item.count != 0 {
            item[1] = list
        }
    }
}

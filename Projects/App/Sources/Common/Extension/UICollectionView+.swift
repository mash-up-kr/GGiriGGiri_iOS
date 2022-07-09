//
//  UICollectionView+.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        let cellIdentifier = String(describing: T.self)
        register(T.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func registerHeader<T: UICollectionReusableView>(_: T.Type, elementKind: String) {
        let cellIdentifier = String(describing: T.self)
        register(T.self,
                 forSupplementaryViewOfKind: elementKind,
                 withReuseIdentifier: cellIdentifier)
    }
}

//
//  MyBoxListCollectionViewDelegate.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol MyBoxListCardDelegate: AnyObject {
    func cellTapped(type: MyBox, id: Int, drawStatus: DrawStatus)
}

final class MyBoxListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    weak var myBoxApplyListCardDelegate: MyBoxListCardDelegate?
    
    private let type: MyBox
    var data = [GifticonCard]()
    
    init(type: MyBox) {
        self.type = type
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == .registered { return }
        guard let drawStatus = data[indexPath.item].drawStatus else { return }
        myBoxApplyListCardDelegate?.cellTapped(type: type, id: data[indexPath.item].gifticonInfo.id, drawStatus: drawStatus)
    }
}

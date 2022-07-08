//
//  ImageCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class ImageCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let viewModel = ImagePickerViewModel()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let target = viewModel.allPhotos.object(at: indexPath.item)
        let size = CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2)
        
        viewModel.imageManager.requestImage(for: target,
                                            targetSize: size,
                                            contentMode: .aspectFit, options: nil) { image, _ in
            cell.configure(with: image)
        }
        return cell
    }
}

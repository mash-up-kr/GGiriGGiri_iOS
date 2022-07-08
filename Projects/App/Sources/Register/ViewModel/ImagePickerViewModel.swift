//
//  ImagePickerViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation
import Photos

struct ImagePickerViewModel {
    
    var allPhotos: PHFetchResult<PHAsset> = {
        let option = PHFetchOptions()
        let sortByDateAsc = NSSortDescriptor(key: "creationDate", ascending: true)
        option.sortDescriptors = [sortByDateAsc]
        return PHAsset.fetchAssets(with: option)
    }()
    
    let imageManager = PHImageManager()
}

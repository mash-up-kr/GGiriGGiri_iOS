//
//  OCRRequestModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/11.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

struct OCRRequestModel: Encodable {
    let imageData: Data
    
    enum CodingKeys: String, CodingKey {
        case imageData = "image"
    }
    
    init(image: UIImage?) {
        imageData = image?.pngData() ?? Data()
    }
}

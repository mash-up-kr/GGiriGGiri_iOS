//
//  RegisterGifticonViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/05.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

protocol RegisterGifticonViewModelProtocol {
    var gifticonImage: UIImage { get set }
}

final class RegisterGifticonViewModel: RegisterGifticonViewModelProtocol {
    var gifticonImage: UIImage
    
    init(gifticonImage: UIImage) {
        self.gifticonImage = gifticonImage
    }
}

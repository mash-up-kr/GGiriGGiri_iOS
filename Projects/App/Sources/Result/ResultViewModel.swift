//
//  ResultViewModel.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

protocol ResultViewModelProtocol {
    var type: GifticonResult { get }
}

final class ResultViewModel: ResultViewModelProtocol {
    var type: GifticonResult = .lose
}

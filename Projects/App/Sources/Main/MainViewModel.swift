//
//  MainViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/18.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

/// ViewModel에서 사용될 property와 method 정의
protocol MainViewModelProtocol {
    var something: Int { get set }
    
    func doSomething()
}

/// ViewModelProtocol 구현
final class MainViewModel: MainViewModelProtocol {
    var something: Int = .zero
    
    func doSomething() { }
}

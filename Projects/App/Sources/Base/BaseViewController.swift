//
//  BaseViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/11.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

/// 모든 ViewController의 기본이 되는 BaseViewController
class BaseViewController<T>: UIViewController {
    var viewModel: T
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configure()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// UI 컴포넌트의 attribute를 설정할 때 사용하는 method
    func configure() { }
    
    /// UI 컴포넌트를 추가 및 배치할 때 사용하는 method
    func setLayout() { }
    
    /// 비동기 처리 binding 시 사용하는 method
    func bind() { }
}

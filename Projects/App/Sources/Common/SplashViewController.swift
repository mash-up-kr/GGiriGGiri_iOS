//
//  SplashViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
import SnapKit

final class SplashViewController: BaseViewController<SplashViewModelProtocol> {
    
    private let disposeBag = DisposeBag()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .designSystem(.logoMain)
        imageView.clipsToBounds = true
        return imageView
    }()
    private var deadlineDataCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayout() {
        super.setLayout()
        
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        view.backgroundColor = .designSystem(.primaryYellow)
    }
    
    override func bind() {
        super.bind()
        
        viewModel.deadlineDataCountUpdated
            .subscribe (onNext: { [weak self] dataCount in
                self?.deadlineDataCount = dataCount
            })
            .disposed(by: disposeBag)
    }
}

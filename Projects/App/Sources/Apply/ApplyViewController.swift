//
//  ApplyViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
import SnapKit

final class ApplyViewController: BaseViewController<ApplyViewModelProtocol> {
    
    private let disposeBag = DisposeBag()
    
    private lazy var navigationBar: DDIPNavigationBar = {
        return DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.back,
            title: "응모하기",
            rightButtonsItem: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .designSystem(.neutralWhite)
    }
    
    override func setLayout() {
        super.setLayout()
        
        
    }
    
    override func configure() {
        super.configure()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        navigationBar.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}

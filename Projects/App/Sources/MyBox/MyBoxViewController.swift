//
//  MyBoxViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/28.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
import SnapKit

final class MyBoxViewController: BaseViewController<MyBoxViewModelProtocol> {
    
    private let disposeBag = DisposeBag()
    
    private lazy var navigationBar: DDIPNavigationBar = {
        return DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.back,
            title: "MY BOX",
            rightButtonsItem: nil)
    }()
    
    private let categoryTapView: DDIPCategoryTapView = {
        return DDIPCategoryTapView(style: .init(leftOption: .box, rightOption: .box))
    }()
    
    private let applyBoxView = ApplyBoxView()
    private let registerBoxView = RegisterBoxView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayout() {
        super.setLayout()
        
        view.addSubviews(with: [categoryTapView, applyBoxView, registerBoxView])
        
        categoryTapView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        applyBoxView.snp.makeConstraints {
            $0.top.equalTo(categoryTapView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        registerBoxView.snp.makeConstraints {
            $0.top.equalTo(categoryTapView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configure() {
        super.configure()
        
        configureNavigationBar()
        
        view.backgroundColor = .designSystem(.primaryYellow)
        
        registerBoxView.isHidden = true
        
        categoryTapView.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.applyBoxView.isHidden = false
            self?.registerBoxView.isHidden = true
        }).disposed(by: disposeBag)
        
        categoryTapView.rightButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.applyBoxView.isHidden = true
            self?.registerBoxView.isHidden = false
        }).disposed(by: disposeBag)
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

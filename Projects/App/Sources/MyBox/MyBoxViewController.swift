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
            $0.leading.trailing.equalToSuperview()
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
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut) {
            self.registerBoxView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
        }
    }
    
    override func configure() {
        super.configure()
        
        configureNavigationBar()
        
        view.backgroundColor = .designSystem(.primaryYellow)
        
        categoryTapView.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self?.applyBoxView.transform = .identity // applyBoxView 위치를 defaultValue로 돌려줌.
                self?.registerBoxView.transform = CGAffineTransform(translationX: self?.view.frame.width ?? 0, y: 0)
            }
        }).disposed(by: disposeBag)
        
        categoryTapView.rightButtonTapEvent.subscribe(onNext: { [weak self] in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self?.registerBoxView.transform = .identity
                self?.applyBoxView.transform = CGAffineTransform(translationX: -(self?.view.frame.width ?? 0) , y: 0)
            }
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

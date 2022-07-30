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
    
    private let myBoxView = MyBoxView()
    private let dataSource = MyBoxCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayout() {
        super.setLayout()
        
        view.addSubviews(with: [categoryTapView, myBoxView])
        
        categoryTapView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        myBoxView.snp.makeConstraints {
            $0.top.equalTo(categoryTapView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        configureNavigationBar()
        
        view.backgroundColor = .designSystem(.primaryYellow)
        
        myBoxView.configureDataSource(dataSource)
        
        categoryTapView.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            // TODO: 응모 BOX로 화면 이동
        }).disposed(by: disposeBag)

        categoryTapView.rightButtonTapEvent.subscribe(onNext: { [weak self] in
            // TODO: 등록 BOX로 화면 이동
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

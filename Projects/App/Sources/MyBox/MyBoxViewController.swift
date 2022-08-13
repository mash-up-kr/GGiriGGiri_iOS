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
        let view = DDIPCategoryTapView()
        view.setLeftTitle(.box)
        view.setRightTitle(.box)
        return view
    }()
    
    private let myBoxView = MyBoxView()
    
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
        
        myBoxView.configureDataSource(viewModel.dataSource)
        myBoxView.configureDelegate(viewModel.delegate)

        categoryTapView.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.myBoxView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                                        at: .centeredHorizontally,
                                                        animated: true)
            
            self?.myBoxView.collectionView.reloadData()
        }).disposed(by: disposeBag)

        categoryTapView.rightButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.myBoxView.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0),
                                                        at: .centeredHorizontally,
                                                        animated: true)
            self?.myBoxView.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeLeft.direction = .left
        swipeLeft.delegate = self
        myBoxView.collectionView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeRight.direction = .right
        swipeRight.delegate = self
        myBoxView.collectionView.addGestureRecognizer(swipeRight)
    }
    
    override func bind() {
        super.bind()
        
        viewModel.push = { [weak self] viewController in
            self?.navigationController?.setNavigationBarHidden(true, animated: false)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewModel.applyListUpdated
            .subscribe(onNext: { [weak self] _ in
                self?.myBoxView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.registerListUpdated
            .subscribe(onNext: { [weak self] _ in
                self?.myBoxView.collectionView.reloadData()
            })
                      
        viewModel.applyListUpdated
            .bind { [weak self] data in
                // TODO: API 연동
            }
        
        viewModel.registerListUpdated
            .bind { [weak self] data in
                // TODO: API 연동
            }
    }
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        navigationBar.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    @objc private func swipeAction(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            categoryTapView.tapRightButton()
        } else {
            categoryTapView.tapLeftButton()        
        }
        myBoxView.collectionView.reloadData()
    }
}

extension MyBoxViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

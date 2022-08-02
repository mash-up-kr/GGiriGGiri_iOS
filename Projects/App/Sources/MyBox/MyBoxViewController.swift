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
    private let delegate = MyBoxCollectionViewDelegate()
    
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
        
        dataSource.item = MockData.myBoxItem
        myBoxView.configureDataSource(dataSource)
        myBoxView.configureDelegate(delegate)
        dataSource.applyDelegate.collectionViewCellDelegate = self
        dataSource.registerDelegate.collectionViewCellDelegate = self
        
        categoryTapView.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.myBoxView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                                        at: .centeredHorizontally,
                                                        animated: true)
        }).disposed(by: disposeBag)

        categoryTapView.rightButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.myBoxView.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0),
                                                        at: .centeredHorizontally,
                                                        animated: true)
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
    
    @objc private func swipeAction(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            myBoxView.collectionView.reloadData()
            return
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

extension MyBoxViewController: MyBoxListCollectionViewCellDelegate {
    func cellTapped(type: MyBox, with index: Int) {
        let resultViewModel = ResultViewModel()
        resultViewModel.type = .win
        let resultViewController = ResultViewController(resultViewModel)
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated: true)
    }
}

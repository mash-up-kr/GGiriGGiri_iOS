//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import UIKit

import DesignSystem

final class MainViewController: BaseViewController<MainViewModelProtocol> {
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
    
    private let collectionView = MainView()
    private lazy var navigationBar: DDIPNavigationBar = {
        let barButton = TapBarButtons()
        return  DDIPNavigationBar(
            leftBarItem: nil,
            title: nil,
            rightButtonsItem: [
                barButton.mybox,
                barButton.notification
            ])
    }()
    private let floatingButton = TempButton()

    override func configure() {
        super.configure()
        view.backgroundColor = .designSystem(.primaryYellow)
        
        collectionView.configureDataSource(viewModel.collectionViewDataSource)
        collectionView.configureDelegate(viewModel.collectionViewDelegate)
        
        floatingButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
        
        bind()
    }
    
    override func setLayout() {
        super.setLayout()
        layoutNavigationBar()
        layoutCollectionView()
        layoutloatingButton()
    }
    
    private func layoutNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func layoutCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func layoutloatingButton() {
        let floatingButtonWidth: CGFloat = 48
        let offsetOfX: CGFloat = 16
        let offsetOfY: CGFloat = 48
        
        view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(offsetOfX)
            $0.bottom.equalToSuperview().inset(offsetOfY)
            $0.size.equalTo(floatingButtonWidth)
        }
    }
    
    private func bind() {
        viewModel.alert = { [weak self] in
            switch $0 {
            case let .normal(message):
                self?.alert(message: message)
            case let .ok(message, title, handler):
                self?.alert(
                    message: message,
                    okTitle: title,
                    okHandler: handler
                )
            }
        }
        viewModel.present = { [weak self] in
            self?.present(type: $0)
        }
        viewModel.selectedImage = { [weak self] image in
            self?.alert(message: "쿠폰 이미지 분석 중~", okHandler: { _ in
                let registerGifticonViewController = RegisterGifticonViewController()
                registerGifticonViewController.giftionImage = image
                registerGifticonViewController.modalPresentationStyle = .fullScreen
                self?.present(registerGifticonViewController, animated: true)
            })
        }
    }
    
    @objc private func addButtonDidTapped() {
        viewModel.registerAction()
    }
    
    private func requestPHPhotoLibraryAuthorization() {
        viewModel.requestAuthorization()
    }
    
    private func present(type: MainViewModel.Present) {
        switch type {
        case let .picker(controller):
            present(controller, animated: true)
        }
    }
}

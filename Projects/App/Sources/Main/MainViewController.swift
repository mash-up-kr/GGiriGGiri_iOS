//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import PhotosUI
import UIKit

import DesignSystem
import RxSwift

final class MainViewController: BaseViewController<MainViewModelProtocol> {
    
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
    
    private let disposeBag = DisposeBag()
    
    private let mainView = MainView()
    private var gifticonList = [GifticonCard]()
    private let myBoxButton = TapBarButtons().mybox
    private lazy var navigationBar: DDIPNavigationBar = {
        return  DDIPNavigationBar(
            leftBarItem: nil,
            title: nil,
            rightButtonsItem: [myBoxButton])
    }()

    private let floatingButton = FloatingButton()
    private let toastView = ToastView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .designSystem(.primaryYellow)
    }

    override func configure() {
        super.configure()
        
        configureNavigationBar()
        configureCollectionView()
        configureFloatingButton()
    }
    
    override func bind() {
        super.bind()
        
        viewModel.alert = { [weak self] _, message, _, _, action in
            self?.alert(message: message, okHandler: action)
        }
        
        viewModel.present = { [weak self] viewController in
            self?.present(viewController, animated: true)
        }
        
        viewModel.push = { [weak self] viewController in
            self?.navigationController?.setNavigationBarHidden(true, animated: false)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewModel.deadlineListUpdated
            .subscribe (onNext: { [weak self] in
                self?.collectionView.reloadCollectionView()
            })
            .disposed(by: disposeBag)
        
        viewModel.categoryListUpdated
            .subscribe(onNext: { [weak self] in
                self?.collectionView.reloadCollectionView()
            })
            .disposed(by: disposeBag)
        
        viewModel.gifticonListUpdated
            .subscribe (onNext: { [weak self] in
                self?.collectionView.reloadCollectionView()
            })
            .disposed(by: disposeBag)
        
        viewModel.applyToast
            .subscribe(onNext: { [weak self] in
                self?.showApplyToast(isSuccessed: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel._applyToast
            .subscribe(onNext: { [weak self] isSuccess, message, error, image in
                self?._showApplyToast(isSuccessed: isSuccess, message: message, error: error, image: image ?? .iconRotateLogoCharacterEmpty)
            })
            .disposed(by: disposeBag)
        
        myBoxButton.rx.tap.subscribe(onNext: { [weak self] in
            let myBoxViewModel = MyBoxViewModel(network: Network())
            let myBoxViewController = MyBoxViewController(myBoxViewModel)
            myBoxViewController.modalPresentationStyle = .fullScreen
            self?.viewModel.push?(myBoxViewController)
        }).disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        mainView.configureDataSource(viewModel.mainDataSource)
        mainView.configureDelegate(viewModel.mainDelegate)
        
        mainView.isDeadlineDataExist = viewModel.isDeadlineDataExist
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureFloatingButton() {
        let floatingButtonWidth: CGFloat = 48
        let offsetOfX: CGFloat = 16
        let offsetOfY: CGFloat = 48
        
        view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(offsetOfX)
            $0.bottom.equalToSuperview().inset(offsetOfY)
            $0.size.equalTo(floatingButtonWidth)
        }
        
        floatingButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonDidTapped() {
        viewModel.addButtonDidTapped()
    }
}

// MARK: - Toast

extension MainViewController {
    private func showApplyToast(isSuccessed: Bool) {
        toastView.configureToastView(
            with: self.view,
            style: isSuccessed ? .apply : .applyMyGifticonFail,
            image: isSuccessed ? .iconLogoCharacter : .iconRotateLogoCharacterEmpty
        )
        toastView.showToastView(with: self.view)
    }
    
    private func _showApplyToast(isSuccessed: Bool, message: String?, error: Error?, image: DDIPAsset.name) {
        if isSuccessed {
            showSuccessToast(image: image)
            return
        } else {
            if let message = message {
                showFailToast(message: message)
                return
            }
            showNetworkFailToast()
            return
        }
    }
    
    private func showSuccessToast(image: DDIPAsset.name) {
        toastView.configureToastView(with: self.view, style: .apply, image: image)
        toastView.showToastView(with: self.view)
    }
    
    private func showNetworkFailToast() {
        toastView.configureToastView(with: self.view, style: .networkFail, image: .iconRotateLogoCharacterEmpty)
        toastView.showToastView(with: self.view)
    }
    
    private func showFailToast(message: String) {
        toastView.configureToastView(with: self.view, title: "응모 실패", description: message, image: .iconRotateLogoCharacterEmpty)
        toastView.showToastView(with: self.view)
    }
}

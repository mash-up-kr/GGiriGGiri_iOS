//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import PhotosUI
import UIKit

import DesignSystem

final class MainViewController: BaseViewController<MainViewModelProtocol> {
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
    
    private let collectionView = MainView()
    private let delegate = MainCollectionViewDelegate()
    private let dataSource = MainCollectionViewDataSource()
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
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        collectionView.configureDataSource(dataSource)
        collectionView.configureDelegate(delegate)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
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
        // TODO: + 버튼 탭 되었을 때의 액션 구현
        // 현재 접근 권한 상태를 확인하고, 권한 상태에 따라 분기하는 handleAuthorizationStatus 메서드 호출.
        let authorizationStatus: PHAuthorizationStatus
        
        if #available(iOS 14, *) {
            authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            authorizationStatus = PHPhotoLibrary.authorizationStatus()
        }
        
        handleAuthorizationStatus(with: authorizationStatus)
    }
    
    /// 사용자에게 접근 권한을 요청하는 메서드
    private func requestPHPhotoLibraryAuthorization() {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
                self.handleAuthorizationStatus(with: authorizationStatus)
            }
        } else {
            PHPhotoLibrary.requestAuthorization { authorizationStatus in
                self.handleAuthorizationStatus(with: authorizationStatus)
            }
        }
    }
    
    /// 현재 PHAuthorizationStatus에 따라 분기해서 처리하는 메서드
    private func handleAuthorizationStatus(with authorizationStatus: PHAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            requestPHPhotoLibraryAuthorization()
        case .restricted:
            DispatchQueue.main.async {
                self.alert(message: "라이브러리 권한이 제한되어있습니다.")
            }
        case .denied:
            DispatchQueue.main.async {
                self.alert(message: "갤러리 접근 권한이 거부되었습니다.", okTitle: "권한 설정하러 가기") { _ in
                    self.dismiss(animated: true)
                } okHandler: { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        case .authorized:
            DispatchQueue.main.async {
                let imagePickerViewController = ImagePickerViewController()
                let navigationController = UINavigationController(rootViewController: imagePickerViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true)
            }
            debugPrint("authorized")
        case .limited:
            debugPrint("limited")
        @unknown default:
            DispatchQueue.main.async {
                self.alert(message: "관리자에게 문의하세요.")
            }
        }
    }
}

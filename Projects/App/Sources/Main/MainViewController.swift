//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import PhotosUI
import UIKit

final class MainViewController: UIViewController {
    
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
     
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let mainView = MainView()
    private let delegate = MainCollectionViewDelegate()
    private let dataSource = MainCollectionViewDataSource()
    private let floatingButton = TempButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        view.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let floatingButtonWidth: CGFloat = 48
        let offsetOfX: CGFloat = 16
        let offsetOfY: CGFloat = 48
        floatingButton.frame = CGRect(x: view.frame.size.width - floatingButtonWidth - offsetOfX,
                                      y: view.frame.size.height - floatingButtonWidth - offsetOfY,
                                      width: floatingButtonWidth,
                                      height: floatingButtonWidth)
    }
    
    private func configure() {
        configureNavigationBar()
        
        floatingButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
        
        mainView.configureDataSource(dataSource)
        mainView.configureDelegate(delegate)
        mainView.addSubview(floatingButton)
        self.view = mainView
    }
    
    private func configureNavigationBar() {
        let button = TempBarButton()
        let myButtonItem = UIBarButtonItem(customView: button.myButton)
        let notiButton = UIBarButtonItem(customView: button.notiButton)
        self.navigationItem.rightBarButtonItems = [notiButton, myButtonItem]
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.title = "DDIP"
    }
    
    @objc private func addButtonDidTapped() {
        // TODO: + 버튼 탭 되었을 때의 액션 구현
        // 현재 접근 권한 상태를 확인하고, 권한 상태에 따라 분기하는 handleAuthorizationStatus 메서드 호출.
        let authorizationStatus: PHAuthorizationStatus
        
        if #available(iOS 14, *) {
            authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            // Fallback on earlier versions
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
            // 최초 실행 시에만 호출되므로, 이 때 접근 권한 요청.
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
            if #available(iOS 14, *) {
                presentPicker()
            } else {
                // Fallback on earlier versions
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
    
    @available(iOS 14, *)
    private func presentPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}


extension MainViewController: PHPickerViewControllerDelegate {
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage else {
                        print("could not load image", error?.localizedDescription ?? "")
                        return
                    }
                }
            }
        }
    }
}

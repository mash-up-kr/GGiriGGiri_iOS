//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import Photos
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
        requestPHPhotoLibraryAuthorization {
        }
    }
    
    private func requestPHPhotoLibraryAuthorization(completion: @escaping () -> Void) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
                switch authorizationStatus {
                case .notDetermined:
                    DispatchQueue.main.async {
                        self.alert(message: "갤러리 접근 권한이 설정되지 않았습니다.")
                        completion()
                    }
                case .restricted:
                    DispatchQueue.main.async {
                        self.alert(message: "라이브러리 권한에 제한이 생겼습니다.")
                        completion()
                    }
                case .denied:
                    DispatchQueue.main.async {
                        self.alert(message: "갤러리 접근 권한이 거부되었습니다.")
                        completion()
                    }
                case .authorized:
                    debugPrint("authorized")
                    completion()
                case .limited:
                    debugPrint("limited")
                    completion()
                @unknown default:
                    DispatchQueue.main.async {
                        self.alert(message: "관리자에게 문의하세요.")
                        completion()
                    }
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization { authorizationStatus in
                switch authorizationStatus {
                case .notDetermined:
                    DispatchQueue.main.async {
                        self.alert(message: "갤러리 접근 권한이 설정되지 않았습니다.")
                        completion()
                    }
                case .restricted:
                    DispatchQueue.main.async {
                        self.alert(message: "라이브러리 권한에 제한이 생겼습니다.")
                        completion()
                    }
                case .denied:
                    DispatchQueue.main.async {
                        self.alert(message: "갤러리 접근 권한이 거부되었습니다.")
                        completion()
                    }
                case .authorized:
                    debugPrint("authorized")
                    completion()
                case .limited:
                    debugPrint("limited")
                    completion()
                @unknown default:
                    DispatchQueue.main.async {
                        self.alert(message: "관리자에게 문의하세요.")
                        completion()
                    }
                }
            }
        }
    }
}

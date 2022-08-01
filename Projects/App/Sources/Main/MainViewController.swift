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
    
    private let collectionView = MainView()
    private let delegate = MainCollectionViewDelegate()
    private let dataSource = MainCollectionViewDataSource()
    private let myBoxButton = TapBarButtons().mybox
    private lazy var navigationBar: DDIPNavigationBar = {
        return  DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.back,
            title: nil,
            rightButtonsItem: [myBoxButton])
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
        
        delegate.collectionViewCellDelegate = self
        
        myBoxButton.rx.tap.subscribe(onNext: { [weak self] in
            let myBoxViewModel = MyBoxViewModel()
            let myBoxViewController = MyBoxViewController(myBoxViewModel)
            myBoxViewController.modalPresentationStyle = .fullScreen
            self?.present(myBoxViewController, animated: true)
        }).disposed(by: disposeBag)
        
        navigationBar.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            let resultViewModel = ResultViewModel()
            resultViewModel.type = .win
            print("viwmOde", resultViewModel.type)
            let resultViewController = ResultViewController(resultViewModel)
            resultViewController.type = .win
            resultViewController.modalPresentationStyle = .fullScreen
            self?.present(resultViewController, animated: true)
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
        let authorizationStatus: PHAuthorizationStatus
        authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        handleAuthorizationStatus(with: authorizationStatus)
    }
    
    /// 사용자에게 접근 권한을 요청하는 메서드
    private func requestPHPhotoLibraryAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
            self.handleAuthorizationStatus(with: authorizationStatus)
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
            presentPhotoPicker()
            debugPrint("authorized")
        case .limited:
            debugPrint("limited")
        @unknown default:
            DispatchQueue.main.async {
                self.alert(message: "관리자에게 문의하세요.")
            }
        }
    }
    
    private func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension MainViewController: MainCollectionViewCellDelegate {
    func gifticonCellTapped(with id: Int) {
        let applyViewModel = ApplyViewModel(gifticonId: id)
        let applyViewController = ApplyViewController(applyViewModel)
        applyViewController.modalPresentationStyle = .fullScreen
        self.present(applyViewController, animated: true)
    }
    
    func categoryCellTapped(with category: Category) {
        // TODO: Category에 따라 정렬하기
        debugPrint(#function)
    }
}

extension MainViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage else {
                        debugPrint("could not load image", error?.localizedDescription ?? "")
                        return
                    }
                    
                    self.alert(message: "쿠폰 이미지 분석 중~", okHandler: { _ in
                        let registerGifticonViewController = RegisterGifticonViewController()
                        registerGifticonViewController.giftionImage = image
                        registerGifticonViewController.modalPresentationStyle = .fullScreen
                        self.present(registerGifticonViewController, animated: true)
                    })
                }
            }
        }
        dismiss(animated: true)
    }
}

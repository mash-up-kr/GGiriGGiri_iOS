//
//  MainViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/18.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import PhotosUI
import UIKit

/// ViewModel에서 사용될 property와 method 정의
protocol MainViewModelProtocol {
    var alert: ((MainViewModel.AlertType) -> ())? { get set }
    var present: ((MainViewModel.Present) -> ())? { get set }
    var selectedImage: ((UIImage) -> ())? { get set }
    var collectionViewDataSource: MainCollectionViewDataSource { get }
    var collectionViewDelegate: MainCollectionViewDelegate { get }
    
    func registerAction()
    func requestAuthorization()
    func handleAuthorizationStatus(status: PHAuthorizationStatus)
}

/// ViewModelProtocol 구현
final class MainViewModel: MainViewModelProtocol {
    enum AlertType {
        case normal(message: String)
        case ok(message: String, title: String, handler: ((UIAlertAction) -> ())? = nil)
    }
    enum Present {
        case picker(PHPickerViewController)
    }
    
    var alert: ((AlertType) -> ())? = nil
    var present: ((Present) -> ())? = nil
    var selectedImage: ((UIImage) -> ())? = nil
    
    let collectionViewDataSource = MainCollectionViewDataSource()
    let collectionViewDelegate = MainCollectionViewDelegate()
    
    func registerAction() {
        let authorizationStatus: PHAuthorizationStatus
        authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        handleAuthorizationStatus(status: authorizationStatus)
    }
    
    func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] in
            self?.handleAuthorizationStatus(status: $0)
        }
    }
    
    func handleAuthorizationStatus(status: PHAuthorizationStatus) {
        DispatchQueue.main.async { [weak self] in
            switch status {
            case .notDetermined:
                self?.requestAuthorization()
            case .restricted:
                self?.alert?(.normal(message: "라이브러리 권한이 제한되어있습니다."))
            case .denied:
                self?.alert?(
                    .ok(
                        message: "갤러리 접근 권한이 거부되었습니다.",
                        title: "권한 설정하기",
                        handler: { _ in
                            guard
                                let settingURL = URL(string: UIApplication.openSettingsURLString),
                                UIApplication.shared.canOpenURL(settingURL)
                            else { return }
                            UIApplication.shared.open(settingURL)
                        }
                    )
                )
            case .authorized:
                var configuration = PHPickerConfiguration()
                configuration.filter = .images
                
                let controller = PHPickerViewController(configuration: configuration)
                controller.delegate = self
                
                self?.present?(.picker(controller))
            case .limited:
                fallthrough
            @unknown default:
                self?.alert?(.normal(message: "관리자에게 문의하세요"))
            }
        }
    }
}

extension MainViewModel: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage else {
                        debugPrint("could not load image", error?.localizedDescription ?? "")
                        return
                    }
                    
                    picker.dismiss(animated: true) {
                        self.selectedImage?(image)
                    }
                }
            }
        }
        
    }
}

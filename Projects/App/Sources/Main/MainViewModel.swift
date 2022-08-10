//
//  MainViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/18.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import PhotosUI
import UIKit

import RxRelay
import RxSwift

/// ViewModel에서 사용될 property와 method 정의
protocol MainViewModelProtocol {
    typealias Alert = ((String?, String, String?, ((UIAlertAction) -> Void)?, ((UIAlertAction) -> Void)?) -> ())
    
    var alert: Alert? { get set }
    var present: ((UIViewController) -> ())? { get set }
    var push: ((UIViewController) -> ())? { get set }
    
    var mainDataSource: MainCollectionViewDataSource { get }
    var mainDelegate: MainCollectionViewDelegate { get }
    
    func presentPhotoPicker()
    func requestPHPhotoLibraryAuthorization()
    func handleAuthorizationStatus(with authorizationStatus: PHAuthorizationStatus)
    func addButtonDidTapped()
}

/// ViewModelProtocol 구현
final class MainViewModel: MainViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    var detailData: [GifticonCard] = []
    private let gifticonService: GifticonService
    
    var alert: Alert? = nil
    var present: ((UIViewController) -> ())? = nil
    var push: ((UIViewController) -> ())? = nil
    
    let mainDataSource = MainCollectionViewDataSource()
    lazy var mainDelegate: MainCollectionViewDelegate = {
        let delegate = MainCollectionViewDelegate()
        delegate.collectionViewCellDelegate = self
        return delegate
    }()
    
    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present?(picker)
    }
    
    init(network: Networking) {
        self.gifticonService = GifticonService(network: network)
    }
}

extension MainViewModel {
    
    /// 사용자에게 접근 권한을 요청하는 메서드
    func requestPHPhotoLibraryAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
            self.handleAuthorizationStatus(with: authorizationStatus)
        }
    }
    
    /// 현재 PHAuthorizationStatus에 따라 분기해서 처리하는 메서드
    func handleAuthorizationStatus(with authorizationStatus: PHAuthorizationStatus) {
        DispatchQueue.main.async {
            switch authorizationStatus {
            case .notDetermined:
                self.requestPHPhotoLibraryAuthorization()
            case .restricted:
                self.alert?(nil, "라이브러리 권한이 제한되어있습니다.", nil, nil, nil)
            case .denied:
                self.alert?(nil, "갤러리 접근 권한이 거부되었습니다.", "권한 설정하러 가기", nil) { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            case .authorized:
                self.presentPhotoPicker()
            case .limited:
                debugPrint("limited")
            @unknown default:
                self.alert?(nil, "관리자에게 문의하세요.", nil, nil, nil)
            }
        }
    }
    
    func addButtonDidTapped() {
        let authorizationStatus: PHAuthorizationStatus
        authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        handleAuthorizationStatus(with: authorizationStatus)
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
                    
                    self.alert?(nil, "쿠폰 이미지 분석 중~", nil, nil, { _ in
                        let viewModel = RegisterGifticonViewModel(
                            network: Network(),
                            categoryRepository: CategoryRepository(CategoryService(network: Network())),
                            gifticonImage: image)
                        let registerGifticonViewController = RegisterGifticonViewController(viewModel)
                        registerGifticonViewController.modalPresentationStyle = .fullScreen
                        self.present?(registerGifticonViewController)
                    })
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

extension MainViewModel: MainCollectionViewCellDelegate {
    func gifticonCellTapped(with id: Int) {
        let applyViewModel = ApplyViewModel(gifticonId: id, network: Network())
        let applyViewController = ApplyViewController(applyViewModel)
        applyViewController.modalPresentationStyle = .fullScreen
        push?(applyViewController)
    }
    
    func categoryCellTapped(with category: Category) {
        // TODO: Category에 따라 정렬하기
        debugPrint(#function)
    }
}

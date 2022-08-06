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
    typealias Alert = ((String?, String, String?, ((UIAlertAction) -> Void)?, ((UIAlertAction) -> Void)?) -> ())
    
    var alert: Alert? { get set }
    var present: ((UIViewController) -> ())? { get set }
    var push: ((UIViewController) -> ())? { get set }
    
    var mainDataSource: MainCollectionViewDataSource { get }
    var mainDelegate: MainCollectionViewDelegate { get }
    
    func presentPhotoPicker()
}

/// ViewModelProtocol 구현
final class MainViewModel: MainViewModelProtocol {
    
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
                        let registerGifticonViewController = RegisterGifticonViewController()
                        registerGifticonViewController.giftionImage = image
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
        let applyViewModel = ApplyViewModel(gifticonId: id)
        let applyViewController = ApplyViewController(applyViewModel)
        applyViewController.modalPresentationStyle = .fullScreen
        push?(applyViewController)
    }
    
    func categoryCellTapped(with category: Category) {
        // TODO: Category에 따라 정렬하기
        debugPrint(#function)
    }
}

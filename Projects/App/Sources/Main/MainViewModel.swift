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
    
    var alert: ((String, ((UIAlertAction) -> ())?) -> ())? { get set }
    var present: ((UIViewController) -> ())? { get set }
    
    func presentPhotoPicker()
}

/// ViewModelProtocol 구현
final class MainViewModel: MainViewModelProtocol {
    
    var alert: ((String, ((UIAlertAction) -> ())?) -> ())? = nil
    var present: ((UIViewController) -> ())? = nil
    
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
                    
                    self.alert?("쿠폰 이미지 분석 중~") { _ in
                        let registerGifticonViewController = RegisterGifticonViewController()
                        registerGifticonViewController.giftionImage = image
                        registerGifticonViewController.modalPresentationStyle = .fullScreen
                        self.present?(registerGifticonViewController)
                    }
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

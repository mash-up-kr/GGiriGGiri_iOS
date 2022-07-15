//
//  ImagePickerViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Photos
import UIKit

final class ImagePickerViewController: UIViewController {

    private let imagePickerView = ImagePickerView()
    private let dataSource = ImageCollectionViewDataSource()
    private let delegate = ImageCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure()
    }
    
    private func configure() {
        configureNavigationBar()

        delegate.imageCollectionViewCellDelegate = self
        
        imagePickerView.configureDataSource(dataSource)
        imagePickerView.configureDelegate(delegate)
        self.view = imagePickerView
    }
    
    private func configureNavigationBar() {
        let closeButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonDidTapped))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(nextButtonDidTapped))
        
        self.navigationItem.leftBarButtonItem = closeButton
        self.navigationItem.rightBarButtonItem = nextButton
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.title = "사진 선택"
    }
    
    @objc private func closeButtonDidTapped() {
        dismiss(animated: true)
    }
    
    @objc private func nextButtonDidTapped() {
        debugPrint("nextButtonDidTapped")
    }
}


extension ImagePickerViewController: ImageCollectionViewCellDelegate {
    func imageCollectionViewCellDidTapped(itemAt indexPath: IndexPath) {
        let registerGifticonTableViewController = RegisterGifticonTableViewController()
        navigationController?.pushViewController(registerGifticonTableViewController, animated: true)
    }
}

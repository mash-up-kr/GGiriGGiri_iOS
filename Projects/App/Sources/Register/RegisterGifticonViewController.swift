//
//  RegisterGifticonViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class RegisterGifticonViewController: UIViewController {

    private let registerGifticonView = RegisterGifticonView()
    var giftionImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        view.addSubview(registerGifticonView)
        
        registerGifticonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        configureNavigationBar()
        
        registerGifticonView.registerGiftionImageView.imageView.image = giftionImage
        registerGifticonView.registerGiftionImageView.delegate = self
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "기프티콘 등록"
    }
}


extension RegisterGifticonViewController: RegisterGifticonImageViewButtonDelegate {
    func originalButtonTapped() {
        let tempViewController = UIViewController()
        present(tempViewController, animated: true)
    }
}

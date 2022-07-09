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
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "기프티콘 등록"
    }
}

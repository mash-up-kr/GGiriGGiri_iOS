//
//  GiftionImageViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/20.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class GiftionImageViewController: UIViewController {

    private(set) var giftionImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        configure()
    }
    
    private func setLayout() {
        view.addSubview(giftionImageView)

        giftionImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configure() {
        view.backgroundColor = .ddip(.neutralWhite)
        
        giftionImageView.contentMode = .scaleAspectFit
    }
}

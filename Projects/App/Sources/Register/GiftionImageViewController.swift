//
//  GiftionImageViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/20.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class GiftionImageViewController: UIViewController {

    private(set) var giftionImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        configure()
    }

    private let grabberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .designSystem(.neutralGray300)
        view.layer.cornerRadius = 5

        return view
    }()
    
    private func setLayout() {
        view.addSubview(giftionImageView)
        view.addSubview(grabberView)

        giftionImageView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(131)
        }

        grabberView.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.width.equalTo(60)
            $0.bottom.equalTo(giftionImageView.snp.top).inset(-8)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configure() {
        view.backgroundColor = .clear
        
        giftionImageView.contentMode = .scaleAspectFill
    }
}

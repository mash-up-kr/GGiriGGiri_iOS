//
//  RegisterGiftionImageView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class RegisterGiftionImageView: BaseView {
    
    private let borderView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }()
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let imageModifyButton = TempButton(title: "원본 보기")
    
    override func setLayout() {
        super.setLayout()
        
        borderView.addSubview(imageView)
        borderView.addSubview(imageModifyButton)
        addSubview(borderView)
        
        imageView.snp.makeConstraints {
            $0.top.leading.equalTo(4)
            $0.trailing.bottom.equalTo(-4)
        }
        
        imageModifyButton.snp.makeConstraints {
            $0.trailing.equalTo(-10)
            $0.bottom.equalTo(-13)
            $0.width.equalTo(96)
            $0.height.equalTo(34)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(6)
            $0.leading.equalTo(16)
            $0.trailing.bottom.equalTo(-16)
        }
    }
}

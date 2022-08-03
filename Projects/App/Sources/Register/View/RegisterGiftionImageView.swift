//
//  RegisterGiftionImageView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

protocol RegisterGifticonImageViewButtonDelegate: AnyObject {
    func originalButtonTapped()
}

/// 기프티콘 정보 - 이미지 등록 뷰
final class RegisterGiftionImageView: BaseView {
    
    weak var delegate: RegisterGifticonImageViewButtonDelegate?
    
    private let borderView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }()
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let imageModifyButton = TempButton(title: "원본 보기")
    
    override func setLayout() {
        super.setLayout()
        
        borderView.addSubviews(with: [imageView, imageModifyButton])
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
    
    override func configure() {
        super.configure()
        
        imageModifyButton.addTarget(self, action: #selector(originalButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func originalButtonTapped(_ sender: UIButton) {
        delegate?.originalButtonTapped()
    }
}

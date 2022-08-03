//
//  RegisterGiftionImageView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

protocol RegisterGifticonImageViewButtonDelegate: AnyObject {
    func originalButtonTapped()
}

/// 기프티콘 정보 - 이미지 등록 뷰

final class RegisterGiftionImageView: BaseView {
    
    weak var delegate: RegisterGifticonImageViewButtonDelegate?
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let seeOriginalButton: UIButton = {
       let button = UIButton()
        button.setTitle("원본보기", for: .normal)
        button.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._14)
        button.backgroundColor = UIColor.designSystem(.neutralBlack)?.withAlphaComponent(0.89)
        button.layer.cornerRadius = 12
        if #available(iOS 15.0, *) {
            button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 22, bottom: 22, trailing: 7)
        } else {
            button.titleEdgeInsets = UIEdgeInsets(top: 7, left: 22, bottom: 22, right: 7)
        }
        
        return button
    }()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [imageView, seeOriginalButton])
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        seeOriginalButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(13)
            
            $0.width.equalTo(96)
            $0.height.equalTo(34)
        }
    }
    
    override func configure() {
        super.configure()
        layer.borderWidth = 2
        layer.borderColor = UIColor.designSystem(.neutralGray300)?.cgColor
        layer.cornerRadius = 15
        clipsToBounds = true
        
        seeOriginalButton.addTarget(self, action: #selector(originalButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func originalButtonTapped(_ sender: UIButton) {
        delegate?.originalButtonTapped()
    }
}

//
//  GifticonIconView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/08/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

protocol GifticonIconViewDelegate: AnyObject {
    func gifticonIconDidTapped()
}

final class GifticonIconView: BaseView {
    
    weak var delegate: GifticonIconViewDelegate?
    
    private let speechView = SpeechView()
    private let bubbleView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_bubble")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_drugstore")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setLayout() {
        super.setLayout()
        
        bubbleView.addSubview(speechView)
        addSubviews(with: [bubbleView, imageView])
        
        speechView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(28)
        }
        
        bubbleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(83)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(bubbleView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(180)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func configure() {
        super.configure()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc private func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            delegate?.gifticonIconDidTapped()
        }
    }
}

fileprivate final class SpeechView: BaseView {
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let bubbleLabel: UILabel = {
        let label = UILabel()
        label.text = "기프티콘 이미지를 보고싶다면?"
        label.textColor = .designSystem(.neutralBlack)
        label.textAlignment = .center
        label.font = .designSystem(.pretendard, family: .regular, size: ._14)
        return label
    }()
    
    private let bubbleBoldLabel: UILabel = {
        let label = UILabel()
        label.text = "아이콘을 눌러보세요!"
        label.textColor = .designSystem(.neutralBlack)
        label.textAlignment = .center
        label.font = .designSystem(.pretendard, family: .bold, size: ._14)
        return label
    }()
    
    override func setLayout() {
        super.setLayout()
        
        verticalStackView.addArrangedSubviews(with: [bubbleLabel, bubbleBoldLabel])
        
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .designSystem(.secondarySkyblue100)
        layer.cornerRadius = 12
    }
}

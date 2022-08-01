//
//  WinView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class WinView: BaseView {

    private let winMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "🎉 당첨을 축하해요!"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._20)
        return label
    }()
    
    private let iconView = IconView()
    
    private let infoWrapperView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .designSystem(.neutralGray100)
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 27
        return stackView
    }()
    
    private let brandWrapperView = CommonInfoView()
    private let productWrapperView = CommonInfoView()
    private let expirationDateWrapperView = CommonInfoView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "갤러리에 저장 후 기프티콘을 확인하세요!"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._14)
        return label
    }()
    
    override func setLayout() {
        super.setLayout()
        
        verticalStackView.addArrangedSubviews(with: [brandWrapperView,
                                                     productWrapperView,
                                                     expirationDateWrapperView])
        infoWrapperView.addSubview(verticalStackView)
        addSubviews(with: [winMessageLabel,
                           iconView,
                           infoWrapperView,
                           descriptionLabel])
        
        
        winMessageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.top.equalTo(winMessageLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        infoWrapperView.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(infoWrapperView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        
        backgroundColor = .clear
        
        iconView.layer.cornerRadius = 15
        infoWrapperView.layer.cornerRadius = 12
        
        brandWrapperView.configure(title: "브랜드", info: "GS25")
        productWrapperView.configure(title: "제품명", info: "5,000원 상품권")
        expirationDateWrapperView.configure(title: "유효기간", info: "2022.02.03")
    }
}

fileprivate final class IconView: BaseView {
    
    private let speechView = SpeechView()
    private let triangleView = TriangleView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_drugstore")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [speechView, triangleView, imageView])
        
        speechView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(72)
        }
        
        triangleView.snp.makeConstraints {
            $0.top.equalTo(speechView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(20)
            $0.height.equalTo(12)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(triangleView.snp.bottom)
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
            print("tapped~")
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
        
        addSubviews(with: [verticalStackView])
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .designSystem(.secondarySkyblue100)
        layer.cornerRadius = 12
    }
}

fileprivate final class TriangleView: BaseView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let heightWidth = self.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0 + heightWidth / 2, y: heightWidth / 2))
        path.addLine(to: CGPoint(x: 0 + heightWidth, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.designSystem(.secondarySkyblue100)?.cgColor

        self.layer.insertSublayer(shape, at: 0)
    }
}

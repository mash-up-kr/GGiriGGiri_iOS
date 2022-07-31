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
    
    private let infoContainerView: BaseView = {
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
    
    private let brandContainerView = CommonInfoView()
    private let productContainerView = CommonInfoView()
    private let expirationDateContainerView = CommonInfoView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "갤러리에 저장 후 기프티콘을 확인하세요!"
        label.textColor = .designSystem(.neutralBlack)
        label.font = .designSystem(.pretendard, family: .bold, size: ._14)
        return label
    }()
    
    override func setLayout() {
        super.setLayout()
        
        verticalStackView.addArrangedSubviews(with: [brandContainerView,
                                                     productContainerView,
                                                     expirationDateContainerView])
        infoContainerView.addSubview(verticalStackView)
        addSubviews(with: [winMessageLabel,
                           iconView,
                           infoContainerView,
                           descriptionLabel])
        
        
        winMessageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.top.equalTo(winMessageLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(infoContainerView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        
        backgroundColor = .clear
        
        iconView.layer.cornerRadius = 15
        infoContainerView.layer.cornerRadius = 12
        
        brandContainerView.configure(title: "브랜드", info: "GS25")
        productContainerView.configure(title: "제품명", info: "5,000원 상품권")
        expirationDateContainerView.configure(title: "유효기간", info: "2022.02.03")
    }
}

fileprivate final class IconView: BaseView {
    
    private let speechView = SpeechView()
    private let triangleView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_polygon")
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
        
        addSubviews(with: [speechView, triangleView, imageView])
        
        speechView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(72)
        }
        
        triangleView.snp.makeConstraints {
            $0.top.equalTo(speechView.snp.bottom)
            $0.centerX.equalToSuperview()
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

        let triangle = UIBezierPath()
        let y = rect.height - sqrt(pow(rect.width, 2) - pow(rect.width/2, 2))
        triangle.move(to: CGPoint(x: 0, y: 0))
        triangle.addLine(to: CGPoint(x: rect.width / 2, y: 0))
        triangle.addLine(to: CGPoint(x: rect.width / 2, y: y / 6))
        triangle.addLine(to: CGPoint(x: 0, y: 0))
        triangle.lineJoinStyle = .round
        triangle.lineWidth = 5

        UIColor.designSystem(.secondarySkyblue100)?.set()
        triangle.stroke()
        triangle.close()
        
        UIColor.designSystem(.secondarySkyblue100)?.setFill()
        triangle.fill()
    }
}

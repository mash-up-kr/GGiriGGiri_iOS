//
//  GifticonDeadLineCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit
import Kingfisher

final class GifticonDeadLineCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GifticonDeadLineCollectionViewCell"
    
    private(set) var gifticonId = 0
    private let brandLabel = TempLabel(color: .black)
    private let nameLabel = TempLabel(color: .black)
    private let expirationDateLabel = TempLabel(color: .black)
    private(set) var isParticipatingButton = TempButton(title: "지금 당장 응모할게요!")
    private let numberOfParticipantsViewLabel = TempLabel(color: .black)
    private let remainingTimeLabel = TempLabel(color: .black)
    
    private let cardView = DDIPDeadlineView(
        style: .init(time: "시간",
                     brand: "브랜드",
                     name: "이름",
                     expirationDate: "유효기간",
                     iconImage: "아이콘이미지"),
        button: .init(
            style: .init(
                buttonColor: .designSystem(.secondaryBlue) ?? .label,
                title: "지금당장응모할게용")),
        applyViewer: .init(viewLabel: "오잉?")
    )
    
    private let gifticonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    func configure(with data: GifticonCard) {
        gifticonId = data.gifticonInfo.id
        brandLabel.text = data.gifticonInfo.brand
        nameLabel.text = data.gifticonInfo.name
        expirationDateLabel.text = data.gifticonInfo.expirationDate
        numberOfParticipantsViewLabel.text = "\(data.numberOfParticipants)"
        remainingTimeLabel.text = data.remainingTime
        gifticonImageView.kf.setImage(with: data.gifticonInfo.url)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

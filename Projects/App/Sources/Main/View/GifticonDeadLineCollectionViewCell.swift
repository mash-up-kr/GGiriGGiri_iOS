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
    
    private let cardView = DDIPDeadlineView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.update(countDownDate: nil)
    }
    
    func configure(with data: GifticonCard) {
        gifticonId = data.gifticonInfo.id
        cardView.update(
            style: .init(
                time: "-",
                brand: data.gifticonInfo.brand,
                name: data.gifticonInfo.name,
                expirationDate: data.gifticonInfo.expirationDate,
                iconImage: .iconCrossFill48
            )
        )
        cardView.update(countDownDate: Date())
    }
}

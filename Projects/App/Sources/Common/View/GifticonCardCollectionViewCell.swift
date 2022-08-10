//
//  GifticonCardCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import Kingfisher
import SnapKit

final class GifticonCardCollectionViewCell: UICollectionViewCell {
   
    static let reuseIdentifier = "GifticonCardCollectionViewCell"
    
    private(set) var gifticonId = 0
    private let brandLabel = TempLabel(color: .black)
    private let nameLabel = TempLabel(color: .black)
    private let expirationDateLabel = TempLabel(color: .black)
    private(set) var isParticipatingButton = TempButton(title: "응모하기")
    private let numberOfParticipantsViewLabel = TempLabel(color: .black)
    private let remainingTimeLabel = TempLabel(color: .black)
    
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
    
    private let listCardView = DDIPListCardView(type: .apply)
    
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
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        contentView.addSubview(listCardView)
        listCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

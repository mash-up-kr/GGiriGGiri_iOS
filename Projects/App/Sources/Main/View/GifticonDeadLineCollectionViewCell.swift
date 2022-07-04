//
//  GifticonDeadLineCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import SnapKit
import UIKit

class GifticonDeadLineCollectionViewCell: UICollectionViewCell {
    
    private let brandLabel = TempLabel(color: .black)
    private let nameLabel = TempLabel(color: .black)
    private let expirationDateLabel = TempLabel(color: .black)
    private let isParticipatingButtonLabel = TempLabel(color: .black)
    private let numberOfParticipantsViewLabel = TempLabel(color: .black)
    private let remainingTimeLabel = TempLabel(color: .black)
    
    private let gifticonImageView: UIImageView = {
        let imageView = UIImageView()
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
        brandLabel.text = data.gifticonInfo.brand
        nameLabel.text = data.gifticonInfo.name
        expirationDateLabel.text = data.gifticonInfo.expirationDate
        
        let imageUrl = data.gifticonInfo.imageUrl 
        
        if imageUrl.count > 0 {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: URL(string: imageUrl)!) {
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.gifticonImageView.image = image
                    }
                }
            }
        } else {
            self.gifticonImageView.image = UIImage(named: "pencil.circle.fill")
        }
        
        isParticipatingButtonLabel.text = "응모하기"
        numberOfParticipantsViewLabel.text = "\(data.numberOfParticipants)"
        remainingTimeLabel.text = data.remainingTime
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        contentView.backgroundColor = .systemPink
        contentView.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        verticalStackView.addArrangedSubview(brandLabel)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(expirationDateLabel)
        verticalStackView.addArrangedSubview(isParticipatingButtonLabel)
        verticalStackView.addArrangedSubview(numberOfParticipantsViewLabel)
        verticalStackView.addArrangedSubview(remainingTimeLabel)
    }
}

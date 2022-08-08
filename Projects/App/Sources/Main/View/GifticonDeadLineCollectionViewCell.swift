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
    private(set) var isParticipatingButton = TempButton(title: "지금 당장 응모할게요!")
    
    private let cardView = DDIPDeadlineCardView()
    
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
                iconImage: .iconCafedesert
            )
        )
        
        if data.isParticipating {
            cardView.update(buttonTitle: "응모 완료", backgroundColor: .secondarySkyblue200)
        } else {
            cardView.update(buttonTitle: "지금 당장 응모할게요!", backgroundColor: .secondaryBlue)
        }
        cardView.update(viewerCount: data.numberOfParticipants)
        cardView.update(countDownDate: Date())
        cardView.enableButton()
    }
}

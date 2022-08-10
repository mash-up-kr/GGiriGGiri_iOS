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
    private(set) var isParticipatingButton = TempButton(title: "응모하기")
    
    private let listCardView = DDIPListCardView(type: .apply)
    
    func configure(with data: GifticonCard) {
        gifticonId = data.gifticonInfo.id
        
        if data.isParticipating {
            listCardView.setListCardDeadlineView(buttonColor: .secondarySkyblue200,
                                                 isHidden: false,
                                                 buttonTitle: .complete,
                                                 titleStatus: .complete,
                                                 leftTime: Date())
        } else {
            listCardView.setListCardDeadlineView(buttonColor: .secondaryBlue,
                                                 isHidden: false,
                                                 buttonTitle: .apply,
                                                 titleStatus: .complete,
                                                 leftTime: Date())
        }
        
        listCardView.setBrandName(brand: data.gifticonInfo.brand)
        listCardView.setName(name: data.gifticonInfo.name)
        listCardView.setExpirationDate(expirationDate: Date())
        listCardView.setApplyViewer(viewer: data.numberOfParticipants)
        listCardView.setImageIcon(image: .iconRotateCafedesert)
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

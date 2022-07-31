//
//  MyBoxListCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class MyBoxListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MyBoxListCollectionViewCell"
    
    var myBoxType: MyBox = .register
    
    private let listCardView = DDIPListCardView(style: .init(brand: "스타벅스",
                                                             name: "아이스 아메리카노",
                                                             expirationDate: "2022.08.02",
                                                             iconImage: "icecream",
                                                             description: "마감까지 6시간 남았습니다."),
                                                alarmButton: .init(style: .init(buttonColor: .designSystem(.secondarySkyblue200)!,
                                                                                titleColor: .designSystem(.neutralWhite),
                                                                                title: .progress,
                                                                                isHidden: false)),
                                                applyViewer: .init(viewLabel: "10"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
        configure()
    }
    
    private func setLayout() {
        contentView.addSubview(listCardView)
        
        listCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(7)
        }
    }
    
    private func configure() {
        backgroundColor = .clear
    }
    
    func configure(with category: MyBox, data: GifticonCard) {
        listCardView.brandLabel.text = data.gifticonInfo.brand
        listCardView.nameLabel.text = data.gifticonInfo.name
        listCardView.expirationLabel.text = data.gifticonInfo.expirationDate
        listCardView.imageIcon.image = UIImage(named: "img_gosim1")
        
        switch category {
        case .apply:
            listCardView.descriptionLabel.text = "응모박스으"
        case .register:
            listCardView.descriptionLabel.text = "등록박스으"
        }
        return
    }
}

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
    
    var myBoxType: MyBox = .apply
    
    private let listCardView: DDIPListCardView = DDIPListCardView(type: .apply)
    
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
        listCardView.setBrandName(brand: data.gifticonInfo.brand)
        listCardView.setName(name: data.gifticonInfo.name)
        listCardView.setExpirationDate(expirationDate: Date())
        listCardView.setImageIcon(image: .iconCafedesert)
        listCardView.setApplyViewer(viewer: data.numberOfParticipants)

        if category == .apply { // apply
            // TODO: 전달받은 값에 따라 결과확인, 응모중, 꽝, 당첨 등 status 변경하기
            listCardView.setAppliedStatusViewType(status: .confirmResult, applyDate: Date())
        } else { // register
            // TODO: 전달받은 값에 따라 응모진행중, 전달완료(Date와 함께), 받은사람 없음 변경하기
            listCardView.setDrawStatusViewType(status: .apply)
        }
    }
}

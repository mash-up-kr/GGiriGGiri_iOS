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
    
    var myBoxType: MyBox = .apply {
        didSet {
            switch myBoxType {
            case .apply:
                listCardView = DDIPListCardView(.progress)
            case .register:
                listCardView = DDIPListCardView(.complete)
            }
        }
    }
    
    private var listCardView: DDIPListCardView? = DDIPListCardView(.complete)
    
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
        guard let listCardView = listCardView else {
            return
        }

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
        
        guard var listCardView = listCardView else { return }
        listCardView.setBrandName(brand: data.gifticonInfo.brand)
        listCardView.setName(name: data.gifticonInfo.name)
        listCardView.setExpirationDate(expirationDate: Date())
        listCardView.setImageIcon(image: .iconCafedesert)
        listCardView.setApplyViewer(viewer: data.numberOfParticipants)

        if category == .apply { // apply
            listCardView = DDIPListCardView(.progress)
            listCardView.setListCardApplyView(applyDate: Date())
        } else { // register
            listCardView = DDIPListCardView(.complete)
            listCardView.setListCardCompleteView(drawDate: Date(), registerStatus: .complete)
        }
    }
}

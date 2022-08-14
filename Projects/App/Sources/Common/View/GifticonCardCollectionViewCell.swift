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
import RxSwift
import SnapKit

final class GifticonCardCollectionViewCell: UICollectionViewCell {
   
    static let reuseIdentifier = "GifticonCardCollectionViewCell"
    
    private let disposeBag = DisposeBag()
    private(set) var gifticonId = 0
    
    private let listCardView = DDIPListCardView(type: .apply)
    
    func configure(with data: GifticonCard) {
        gifticonId = data.gifticonInfo.id
        
        // TODO: 현재로부터 뿌리기까지 남은 시간으로 바꿔줘야함
        if data.isParticipating {
            listCardView.setApplyViewType(status: .complete, leftTime: Date())
        } else {
            listCardView.setApplyViewType(status: .enable, leftTime: Date())
        }
        
        listCardView.setBrandName(brand: data.gifticonInfo.brand)
        listCardView.setName(name: data.gifticonInfo.name)
        listCardView.setExpirationDate(expirationDate: data.gifticonInfo.expirationDate.fullStringDate())
        listCardView.setApplyViewer(viewer: data.numberOfParticipants)
        listCardView.setImageIcon(image: data.gifticonInfo.rotateImageName)
        listCardView.cardListButtonDidTapped.subscribe { [weak self] _ in
            // TODO: 현재로부터 뿌리기까지 남은 시간으로 바꿔줘야함
            self?.listCardView.setApplyViewType(status: .complete, leftTime: Date())
        }.disposed(by: disposeBag)
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

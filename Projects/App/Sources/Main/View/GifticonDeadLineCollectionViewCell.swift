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
import RxSwift

final class GifticonDeadLineCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GifticonDeadLineCollectionViewCell"
    
    private let disposeBag = DisposeBag()
    private(set) var gifticonId = 0
    
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
            cardView.disableButton()
        } else {
            cardView.update(buttonTitle: "지금 당장 응모할게요!", backgroundColor: .secondaryBlue)
            cardView.enableButton()
            cardView.CTAButton.rx.tap.asObservable()
                .subscribe { _ in
                    // TODO: 응모 POST 완료 되면 button update 되도록 수정하기. 완료되지 않을 경우는 실패 ToastView 띄우도록 하기
                    self.cardView.update(buttonTitle: "응모 완료", backgroundColor: .secondarySkyblue200)
                    self.cardView.disableButton()
                }.disposed(by: disposeBag)

        }
        cardView.update(viewerCount: data.numberOfParticipants)
        cardView.update(countDownDate: Date())
    }
}

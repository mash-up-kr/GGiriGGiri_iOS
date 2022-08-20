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
import RxRelay

final class GifticonDeadLineCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GifticonDeadLineCollectionViewCell"
    
    private var disposeBag = DisposeBag()
    private(set) var gifticonId = 0
    
    weak var gifticonApplyButtonDelegate: GifticonApplyButtonDelegate?
    
    private let cardView = DDIPDeadlineCardView()
    
    let didApplyButtonTapped = PublishRelay<Int>()
    let countdownTimeOver = PublishRelay<Void>()
    
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
        disposeBag = DisposeBag()
        bind()
        
        cardView.update(countDownDate: nil)
        updateApplyButton(isApplied: false)
    }
    
    private func bind() {
        cardView.countdownTimeOver
            .bind(to: countdownTimeOver)
            .disposed(by: disposeBag)
    }
    
    private func updateApplyButton(isApplied: Bool = true) {
        if isApplied {
            cardView.update(
                buttonTitle: "응모 완료",
                backgroundColor: .secondarySkyblue200
            )
        } else {
            cardView.update(
                buttonTitle: "지금 당장 응모할게요!",
                backgroundColor: .secondaryBlue
            )
        }
    }
    
    func configure(with data: GifticonCard) {
        bind()
        
        gifticonId = data.gifticonInfo.id
        cardView.update(
            style: .init(
                time: data.sprinkleTime,
                brand: data.gifticonInfo.brand,
                name: data.gifticonInfo.name,
                expirationDate: data.gifticonInfo.expirationDate,
                iconImage: data.gifticonInfo.category.assetName
            )
        )
        
        cardView.CTAButton.rx.tap.asObservable()
            .subscribe { _ in
                self.gifticonApplyButtonDelegate?.applyButtonTapped(with: self.gifticonId, categoryImage: data.gifticonInfo.standardImageName, completion: { status in
                    if status {
                        self.cardView.update(buttonTitle: "응모 완료", backgroundColor: .secondarySkyblue200)
                        self.cardView.disableButton()
                        self.cardView.update(viewerCount: data.numberOfParticipants)
                        self.updateApplyButton(isApplied: data.isParticipating)
                    }
                })
            }.disposed(by: disposeBag)
        cardView.update(viewerCount: data.numberOfParticipants)
        updateApplyButton(isApplied: data.isParticipating)
    }
}

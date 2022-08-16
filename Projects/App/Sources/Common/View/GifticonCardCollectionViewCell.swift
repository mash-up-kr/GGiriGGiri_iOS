//
//  GifticonCardCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxRelay
import RxSwift
import SnapKit

protocol GifticonApplyButtonDelegate: AnyObject {
    func applyButtonTapped(with id: Int, categoryImage: DDIPAsset.name, completion: @escaping (Bool) -> ())
}

final class GifticonCardCollectionViewCell: UICollectionViewCell {
   
    static let reuseIdentifier = "GifticonCardCollectionViewCell"
    
    weak var gifticonApplyButtonDelegate: GifticonApplyButtonDelegate?
    
    private var disposeBag = DisposeBag()
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
        
        bind(with: data)
        listCardView.setBrandName(brand: data.gifticonInfo.brand)
        listCardView.setName(name: data.gifticonInfo.name)
        listCardView.setExpirationDate(expirationDate: data.gifticonInfo.expirationDate.fullStringDate())
        listCardView.setApplyViewer(viewer: data.numberOfParticipants)
        listCardView.setImageIcon(image: data.gifticonInfo.rotateImageName)
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
    
    private func bind(with data: GifticonCard) {
        listCardView.cardListButtonDidTapped
            .withUnretained(self)
            .subscribe { [weak self] _ in
            self?.gifticonApplyButtonDelegate?.applyButtonTapped(with: data.gifticonInfo.id,
                                                                 categoryImage: data.gifticonInfo.standardImageName,
                                                                 completion: { status in
                // TODO: 현재로부터 뿌리기까지 남은 시간으로 바꿔줘야함
                if status {
                    self?.listCardView.setApplyViewType(status: .complete, leftTime: data.sprinkleTime.fullStringDate())
                    self?.listCardView.setApplyViewer(viewer: data.numberOfParticipants + 1)
                } else {
                    // TODO: 응모 실패했을 경우 처리해야함
                    self?.listCardView.setApplyViewType(status: .enable, leftTime: data.sprinkleTime.fullStringDate())
                }
            })
        }.disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}

//
//  MyBoxListCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift

protocol MyBoxListResultButtonDelegate: AnyObject {
    func resultButtonTapped(with id: Int, result: DrawStatus)
}

final class MyBoxListCollectionViewCell: UICollectionViewCell {
    
    weak var resultButtonDelegate: MyBoxListResultButtonDelegate?
    static let reuseIdentifier = "MyBoxListCollectionViewCell"
    
    private let disposeBag = DisposeBag()
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
        listCardView.setExpirationDate(expirationDate: data.gifticonInfo.expirationDate.fullStringDate())
        listCardView.setImageIcon(image: data.gifticonInfo.rotateImageName)
        listCardView.setApplyViewer(viewer: data.numberOfParticipants)

        // MARK: 응모 BOX
        if category == .applied {
            // 응모가 진행 중일 경우
            if data.drawStatus == .progress {
                listCardView.setApplyViewType(status: .complete, leftTime: data.sprinkleTime.fullStringDate())
                return
            }
            
            // 응모가 마감된 경우
            guard let resultChecked = data.isChecked,
                  let result = data.drawStatus,
                  let participateDate = data.participateDate else { return }
            if resultChecked { // 이미 결과를 확인한 경우, 그대로 결과 표시
                if result == .win { // 당첨
                    listCardView.setAppliedStatusViewType(status: .win, applyDate: participateDate.fullStringDate())
                } else if result == .lose { // 꽝
                    listCardView.setAppliedStatusViewType(status: .lose, applyDate: participateDate.fullStringDate())
                }
            } else { // 결과를 아직 확인하지 않은 경우, 결과 확인 버튼 표시
                listCardView.setAppliedStatusViewType(status: .confirmResult, applyDate: participateDate.fullStringDate())
                listCardView.cardListButtonDidTapped.subscribe { buttonStatus in
                    // 결과에 따라 이동
                    self.resultButtonDelegate?.resultButtonTapped(with: data.gifticonInfo.id, result: result)
                }.disposed(by: disposeBag)
            }
        } else { // MARK: 등록 BOX
            // 뿌리기 상태 확인
            guard let sprinkledStatus = data.sprinkledStatus else { return }
            
            switch sprinkledStatus {
            case .finish: // 응모 마감. 전달 완료
                guard let deliveryDate = data.deliveryDate else { return }
                listCardView.setDrawStatusViewType(drawDate: deliveryDate.fullStringDate(), status: .complete)
            case .noParticipants: // 응모 마감. 받은 사람 없음
                listCardView.setDrawStatusViewType(status: .nobody)
            case .progress: // 응모 진행 중
                listCardView.setDrawStatusViewType(status: .apply)
            }
        }
    }
}

//
//  MainCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift
import RxRelay

final class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var deadLineData: [GifticonCard] = []
    private var categoryData: [Category] = []
    private var gifticonListData: [GifticonCard] = []
    
    var didTapDeadLineApplyButton = PublishRelay<Int>()
    var didDeadLineCountDownTimeOver = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: 마감임박 데이터 없을 때의 경우 처리 필요
        return MainSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return deadLineData.count
        case 1:
            return categoryData.count
        case 2:
            return gifticonListData.count
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MockData.main[indexPath.section] {
        case .deadLine:
            guard let cell = collectionView.dequeReusableCell(GifticonDeadLineCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            let deadlineData = deadLineData[indexPath.item]
            cell.configure(with: deadlineData)
            cell.didApplyButtonTapped
                .bind(to: didTapDeadLineApplyButton)
                .disposed(by: disposeBag)
            cell.countDownTimeOver
                .bind(to: didDeadLineCountDownTimeOver)
                .disposed(by: disposeBag)
            return cell
        case .category:
            guard let cell = collectionView.dequeReusableCell(CategoryCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            let category = categoryData[indexPath.item]
            cell.configure(category)
            return cell
        case .gifticonList:
            guard let cell = collectionView.dequeReusableCell(GifticonCardCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            let gifticonListData = gifticonListData[indexPath.item]
            cell.configure(with: gifticonListData)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: BaseHeaderView.reuseIdentifier,
                                              for: indexPath) as? BaseHeaderView else {
            return UICollectionReusableView()
        }
        supplementaryView.titleLabel.text = MainSection.allCases[indexPath.section].headerTitle
        return supplementaryView
    }
}

extension MainCollectionViewDataSource {
    
    func updateDeadLineData(_ list: [GifticonCard]) {
        deadLineData = list
    }
    
    func updateCategoryData(_ list: [Category]) {
        categoryData = list
    }
    
    func updateGifticonListData(_ list: [GifticonCard]) {
        gifticonListData = list
    }
}

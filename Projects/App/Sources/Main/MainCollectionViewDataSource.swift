//
//  MainCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
import RxRelay

final class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    weak var buttonDelegate: GifticonApplyButtonDelegate?
    
    private var deadLineData: [GifticonCard] = []
    private var categoryData: [Category] = []
    private var gifticonListData: [GifticonCard] = []
    
    var didTapDeadLineApplyButton = PublishRelay<Int>()
    var didDeadLineCountdownTimeOver = PublishRelay<Void>()
    var selectedCategoryIndexPath: IndexPath? = nil
    
    private let disposeBag = DisposeBag()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: 마감임박 데이터 없을 때의 경우 처리 필요
        return MainSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = MainSection(rawValue: section) else {
            return .zero
        }
        switch sectionType {
        case .deadLine:
            return deadLineData.count
        case .category:
            return categoryData.count
        case .gifticonList:
            return gifticonListData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = MainSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        switch section {
        case .deadLine:
            guard let cell = collectionView.dequeReusableCell(GifticonDeadLineCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            let deadlineData = deadLineData[indexPath.item]
            cell.configure(with: deadlineData)
            cell.gifticonApplyButtonDelegate = self
            cell.didApplyButtonTapped
                .bind(to: didTapDeadLineApplyButton)
                .disposed(by: disposeBag)
            cell.countdownTimeOver
                .bind(to: didDeadLineCountdownTimeOver)
                .disposed(by: disposeBag)
            return cell
        case .category:
            guard let cell = collectionView.dequeReusableCell(CategoryCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            let category = categoryData[indexPath.item]
            let isAlreadySelectedRow = selectedCategoryIndexPath?.row ?? .zero == indexPath.row
            cell.configure(
                category,
                isAlreadySelected: isAlreadySelectedRow
            )
            return cell
        case .gifticonList:
            guard let cell = collectionView.dequeReusableCell(GifticonCardCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            let gifticonListData = gifticonListData[indexPath.item]
            cell.configure(with: gifticonListData)
            cell.gifticonApplyButtonDelegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BaseHeaderView.reuseIdentifier,
                for: indexPath
            ) as? BaseHeaderView,
            let sectionType = MainSection(rawValue: indexPath.section)
        else {
            return UICollectionReusableView()
        }
        supplementaryView.titleLabel.text = sectionType.headerTitle
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

extension MainCollectionViewDataSource {
    func category() -> [Category] {
        categoryData
    }
}

extension MainCollectionViewDataSource: GifticonApplyButtonDelegate {
    func applyButtonTapped(with id: Int, categoryImage: DDIPAsset.name, completion: @escaping (Bool) -> ()) {
        buttonDelegate?.applyButtonTapped(with: id, categoryImage: categoryImage, completion: { status in
            completion(status)
        })
    }
}

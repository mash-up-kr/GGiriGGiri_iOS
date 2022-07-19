//
//  MainCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MockData.main.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MockData.main[section] {
        case .deadLine(let items):
            return items.count
        case .category(let items):
            return items.count
        case .gifticonList(let items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MockData.main[indexPath.section] {
        case .deadLine(let items):
            guard let cell = collectionView.dequeReusableCell(GifticonDeadLineCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            cell.isParticipatingButton.addTarget(self,
                                                 action: #selector(applyDeadLineButtonTapped(_:)),
                                                 for: .touchUpInside)
            return cell
        case .category(_):
            guard let cell = collectionView.dequeReusableCell(CategoryCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.configure(Category.allCases, with: indexPath.item)
            return cell
        case .gifticonList(let items):
            guard let cell = collectionView.dequeReusableCell(GifticonCardCollectionViewCell.self,
                                                              for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            cell.isParticipatingButton.addTarget(self,
                                                 action: #selector(applyButtonTapped(_:)),
                                                 for: .touchUpInside)
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
    
    @objc private func applyDeadLineButtonTapped(_ sender: UIButton) {
        sender.currentTitle == "지금 당장 응모할게요!" ?
        sender.setTitle("응모완료", for: .normal) : sender.setTitle("지금 당장 응모할게요!", for: .normal)
    }
    
    @objc private func applyButtonTapped(_ sender: UIButton) {
        sender.currentTitle == "응모하기" ?
        sender.setTitle("응모완료", for: .normal) : sender.setTitle("응모하기", for: .normal)
    }
}

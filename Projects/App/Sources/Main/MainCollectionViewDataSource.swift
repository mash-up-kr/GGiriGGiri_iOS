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
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GifticonDeadLineCollectionViewCell.reuseIdentifier,
                for: indexPath) as? GifticonDeadLineCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            cell.isParticipatingButton.addTarget(self,
                                                 action: #selector(applyDeadLineButtonTapped(_:)),
                                                 for: .touchUpInside)
            configureImage(with: cell.imageURL) { image in
                if let image = image {
                    cell.configureImage(with: image)
                }
            }
            return cell
        case .category(_):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier,
                for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: indexPath.item)
            return cell
        case .gifticonList(let items):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GifticonCardCollectionViewCell.reuseIdentifier,
                for: indexPath) as? GifticonCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            cell.isParticipatingButton.addTarget(self,
                                                 action: #selector(applyButtonTapped(_:)),
                                                 for: .touchUpInside)
            configureImage(with: cell.imageURL) { image in
                if let image = image {
                    cell.configureImage(with: image)
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: CommonHeaderView.reuseIdentifier,
                                              for: indexPath) as? CommonHeaderView else {
            return UICollectionReusableView()
        }
        supplementaryView.titleLabel.text = MainSection.allCases[indexPath.section].headerTitle
        return supplementaryView
    }
    
    private func configureImage(with imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        if imageUrl.count > 0 {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: URL(string: imageUrl)!) {
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        } else {
            completion(UIImage(systemName: "pencil"))
        }
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

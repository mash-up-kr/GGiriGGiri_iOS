//
//  MainCollectionViewDataSource.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/03.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var mainData: [MainSection] = [
        .deadLine([GifticonListCardItem(remainingTime: "123초",
                                        gifticonInfo:
                                          Gifticon(brand: "스타벅스",
                                                   name: "아메리카노",
                                                   expirationDate: "20220626",
                                                   imageUrl: ""),
                                        numberOfParticipants: 5,
                                        isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false)]),
        .category(CategoryList.allCases),
        .deadLine([GifticonListCardItem(remainingTime: "123초",
                                        gifticonInfo:
                                          Gifticon(brand: "스타벅스",
                                                   name: "아메리카노",
                                                   expirationDate: "20220626",
                                                   imageUrl: ""),
                                        numberOfParticipants: 5,
                                        isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false),GifticonListCardItem(remainingTime: "123초",
                                                                                                          gifticonInfo:
                                                                                                            Gifticon(brand: "스타벅스",
                                                                                                                     name: "아메리카노",
                                                                                                                     expirationDate: "20220626",
                                                                                                                     imageUrl: ""),
                                                                                                          numberOfParticipants: 5,
                                                                                                          isParticipating: false),
                   GifticonListCardItem(remainingTime: "123초",
                                                             gifticonInfo:
                                                               Gifticon(brand: "스타벅스",
                                                                        name: "아메리카노",
                                                                        expirationDate: "20220626",
                                                                        imageUrl: ""),
                                                             numberOfParticipants: 5,
                                                             isParticipating: false)])
    ]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mainData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch mainData[section] {
        case .deadLine(let items):
            return items.count
        case .category(let items):
            return items.count
        case .gifticonList(let items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch mainData[indexPath.section] {
        case .deadLine(let items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonDeadLineCollectionViewCell.self), for: indexPath) as? GifticonDeadLineCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            return cell
        case .category(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: indexPath.item)
            return cell
        case .gifticonList(let items):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GifticonDeadLineCollectionViewCell.self), for: indexPath) as? GifticonDeadLineCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: items[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: String(describing: CommonHeaderView.self),
                                              for: indexPath) as? CommonHeaderView else {
            return UICollectionReusableView()
        }
        supplementaryView.titleLabel.text = MainSection.allCases[indexPath.section].headerTitle
        return supplementaryView
    }
}

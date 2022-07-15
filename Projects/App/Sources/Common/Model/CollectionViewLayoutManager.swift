//
//  CollectionViewLayoutManager.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

struct CollectionViewLayoutManager {
    
    static func configureItem(with itemSize: CollectionViewConfigureSize, inset: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension,
                                              heightDimension: itemSize.heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = inset
        return item
    }

    static func configureGroup(with groupSize: CollectionViewConfigureSize,
                        inset: NSDirectionalEdgeInsets = .zero,
                        isDirectionVertical: Bool = false,
                        item: NSCollectionLayoutItem, itemCount: Int = 0) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: groupSize.widthDimension,
                                               heightDimension: groupSize.heightDimension)
        let group: NSCollectionLayoutGroup
        
        if isDirectionVertical {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            return group
        }
        group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return group
    }
    
    static func configureHeader(with headerSize: CollectionViewConfigureSize, elementKind: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: headerSize.widthDimension,
                                                heightDimension: headerSize.heightDimension)
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: elementKind,
                                                                 alignment: .top)
        return header
    }
    
    static func configureSection(with group: NSCollectionLayoutGroup,
                                 contentInsets: NSDirectionalEdgeInsets = .zero,
                                 scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior?,
                                 header: NSCollectionLayoutBoundarySupplementaryItem?) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = contentInsets
        
        if let scrollingBehavior = scrollingBehavior {
            section.orthogonalScrollingBehavior = scrollingBehavior
        }
        
        if let header = header {
            section.boundarySupplementaryItems = [header]
        }
        return section
    }
}

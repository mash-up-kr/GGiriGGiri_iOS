//
//  RegisterGifticonInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

/// 기프티콘 정보 - 기프티콘 정보 뷰
final class RegisterGifticonInfoView: BaseView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기프티콘 정보"
        label.font = .designSystem(.pretendard, family: .bold, size: ._16)
        label.textColor = .designSystem(.neutralBlack)
        return label
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = .designSystem(.pretendard, family: .regular, size: ._14)
        label.textColor = .designSystem(.neutralBlack)
        return label
    }()
    
    private lazy var categoryView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .yellow
        collectionView.register(CategoryCollectionViewCell.self)
        return collectionView
    }()
    
    private let barndIntputView = DDIPInputView(title: "브랜드", placeholder: "브랜드명을 입력해주세요.")
    private let nameInputView = DDIPInputView(title: "제품명", placeholder: "제품명을 입력해주세요.")
    private let expirationDateInputView = DDIPInputView(inputType: .text,
                                                             title: "유효기간",
                                                             placeholder: "유효기간(YYYY.MM.DD)을 입력해주세요")
    private func generateLayout() -> UICollectionViewLayout {
        let layout =
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return self.generateCategorySection()
        }
        return layout
    }
    
    private func generateCategorySection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .estimated(1),
                                                                    heightDimension: .estimated(1)))
        
        let group = CollectionViewLayoutManager.configureGroup(with:
                                                                CollectionViewConfigureSize(
                                                                    widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .estimated(1)),
                                                               item: item)
        
        let section = CollectionViewLayoutManager.configureSection(with: group,
                                                                   scrollingBehavior: nil,
                                                                   header: nil)
        return section
    }
    
    private let categoryCollectionViewDataSource = CategoryCollectionViewDataSource()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [titleLabel,
                           categoryTitleLabel,
                           categoryView,
                           barndIntputView,
                           nameInputView,
                           expirationDateInputView])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        categoryTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(20)
        }
        
        categoryView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(categoryTitleLabel.snp.bottom).offset(16)
            $0.height.equalTo(81)
        }
        
        barndIntputView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        nameInputView.snp.makeConstraints {
            $0.top.equalTo(barndIntputView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }

        expirationDateInputView.snp.makeConstraints {
            $0.top.equalTo(nameInputView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        categoryView.dataSource = categoryCollectionViewDataSource
        expirationDateInputView.update(keyboardType: .numberPad)
        expirationDateInputView.update { [weak self] text in
            let count = text?.count ?? .zero
            if count != 8 {
                self?.expirationDateInputView.update(helperText: "유효기간은 8자리(YYYYMMDD)로 입력해주세요.")
                self?.expirationDateInputView.update(state: .error)
                return false
            }
            return true
        }
    }
}

//
//  RegisterGifticonInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

/// 기프티콘 정보 - 기프티콘 정보 뷰
final class RegisterGifticonInfoView: BaseView {
    
    private let titleLabel = TempLabel(color: .black,
                                       text: "기프티콘 정보",
                                       font: .systemFont(ofSize: 16))
    
    private let categoryLabel = TempLabel(color: .black,
                                          text: "카테고리",
                                          font: .systemFont(ofSize: 14))
    
    private lazy var categoryView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .yellow
        collectionView.register(CategoryCollectionViewCell.self)
        return collectionView
    }()
    
    private let brandContainer = RegisterInfoInputView()
    private let productContainer = RegisterInfoInputView()
    private let expirationDateContainer = RegisterInfoInputView()
    private let warningMessageLabel = TempLabel(color: .red,
                                         text: "유효기간은 8자리(YYYYMMDD)로 입력해주세요.",
                                         font: .systemFont(ofSize: 14))
    
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
        
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(categoryView)
        addSubview(brandContainer)
        addSubview(productContainer)
        addSubview(expirationDateContainer)
        addSubview(warningMessageLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(20)
        }
        
        categoryView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(categoryLabel.snp.bottom).offset(16)
            $0.height.equalTo(81)
        }
        
        brandContainer.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82)
        }
        
        productContainer.snp.makeConstraints {
            $0.top.equalTo(brandContainer.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82)
        }

        expirationDateContainer.snp.makeConstraints {
            $0.top.equalTo(productContainer.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82)
        }
        
        warningMessageLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(expirationDateContainer.snp.bottom).offset(4)
            $0.height.equalTo(20)
        }
    }
    
    override func configure() {
        super.configure()
        
        categoryView.dataSource = categoryCollectionViewDataSource
        brandContainer.configure(with: "브랜드", placeholder: "브랜드명")
        productContainer.configure(with: "제품명", placeholder: "제품명")
        expirationDateContainer.configure(with: "유효기간", placeholder: "유효기간(YYYY.MM.DD)")
    }
}

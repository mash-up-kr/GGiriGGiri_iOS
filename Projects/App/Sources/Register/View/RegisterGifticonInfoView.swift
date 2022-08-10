//
//  RegisterGifticonInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
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
        collectionView.register(CategoryCollectionViewCell.self)
        return collectionView
    }()
    
    private let brandInputView = DDIPInputView(title: "브랜드", placeholder: "브랜드명을 입력해주세요")
    private let nameInputView = DDIPInputView(title: "제품명", placeholder: "제품명을 입력해주세요")
    private let expirationDateInputView = DDIPInputView(inputType: .text,
                                                             title: "유효기간",
                                                             placeholder: "유효기간(YYYY.MM.DD)을 입력해주세요")
    
    private let disposeBag = DisposeBag()
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, _) in
            return self.generateCategorySection()
        }
        return layout
    }
    
    private func generateCategorySection() -> NSCollectionLayoutSection {
        let item = CollectionViewLayoutManager.configureItem(
            with: CollectionViewConfigureSize(
                widthDimension: .estimated(10),
                heightDimension: .absolute(34)
            )
        )
        
        let group = CollectionViewLayoutManager.configureGroup(
            with: CollectionViewConfigureSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(34)
            ),
            edgeSpacing: .init(
                leading: .none,
                top: .none,
                trailing: .fixed(10),
                bottom: .fixed(10)
            ),
            item: item
        )
        
        let section = CollectionViewLayoutManager.configureSection(
            with: group,
            scrollingBehavior: nil,
            header: nil
        )
        
        return section
    }
    
    private let categoryCollectionViewDataSource = CategoryCollectionViewDataSource()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    var didSelectCategory: ((Int) -> ())?
    var didUpdateBrandName: ((String?) -> ())?
    var didUpdateProductName: ((String?) -> ())?
    var didUpdateExpirationDate: ((String?) -> ())?
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubviews(with: [titleLabel,
                                             categoryTitleLabel,
                                             categoryView,
                                             inputStackView])
        
        stackView.setCustomSpacing(20, after: titleLabel)
        stackView.setCustomSpacing(16, after: categoryTitleLabel)
        stackView.setCustomSpacing(24, after: categoryView)
        
        inputStackView.addArrangedSubviews(with: [
            brandInputView,
            nameInputView,
            expirationDateInputView
        ])
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        categoryTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        categoryView.snp.makeConstraints {
            $0.height.equalTo(81)
        }
    }
    
    override func configure() {
        super.configure()
        categoryView.dataSource = categoryCollectionViewDataSource
        categoryView.delegate = self
        categoryView.rx.observe(CGSize.self, "contentSize")
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let size = $0, size.height != .zero else { return }
                self?.updateCategoryViewHeight(size.height)
            })
            .disposed(by: disposeBag)
        
        brandInputView.textRelay
            .subscribe(onNext: { [weak self] in
                self?.didUpdateBrandName?($0)
            })
            .disposed(by: disposeBag)
        
        nameInputView.textRelay
            .subscribe(onNext: { [weak self] in
                self?.didUpdateProductName?($0)
            })
            .disposed(by: disposeBag)
        
        expirationDateInputView.textRelay
            .subscribe(onNext: { [weak self] in
                self?.didUpdateExpirationDate?($0)
            })
            .disposed(by: disposeBag)
        
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
    
    private func updateCategoryViewHeight(_ height: CGFloat) {
        categoryView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
    func updateCategoryDataSource(_ data: [String]) {
        categoryCollectionViewDataSource.update(data)
        categoryView.reloadData()
    }
    
    func update(brandName: String?) {
        brandInputView.update(text: brandName)
    }
    
    func update(productName: String?) {
        nameInputView.update(text: productName)
    }
    
    func update(expirationDate: String?) {
        expirationDateInputView.update(text: expirationDate)
    }
}

// TODO: datasource와 같은수준으로 빼기
extension RegisterGifticonInfoView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        cell.updateButton(isSelected: true)
        didSelectCategory?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        cell.updateButton(isSelected: false)
    }
}

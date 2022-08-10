//
//  CategoryRepository.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import RxRelay
import RxSwift

protocol CategotyRespositoryProtocol {
    var categoryEntity: BehaviorRelay<CategoryEntity> { get }
    
    func fetchCategories()
}

final class CategoryRepository: CategotyRespositoryProtocol {
    private let disposeBag = DisposeBag()
    private let categoryService = CategoryService(network: Network())
    
    var categoryEntity = BehaviorRelay<CategoryEntity>(value: CategoryEntity())
    
    func fetchCategories() {
        categoryService.categories()
            .subscribe(onSuccess: { [weak self] in
                guard let categoriesModel = $0.data else { return }
                self?.categoryEntity.accept(CategoryEntity(categoriesModel))
            })
            .disposed(by: disposeBag)
    }
}

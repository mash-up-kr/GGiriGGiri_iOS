//
//  CategoryRepository.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import RxRelay
import RxSwift

protocol CategotyRespositoryLogic {
    var categoryEntity: BehaviorRelay<CategoryEntity> { get }
    
    func fetchCategories()
}

final class CategoryRepository: CategotyRespositoryLogic {
    private let disposeBag = DisposeBag()
    private let categoryService: CategoryServiceLogic
    
    var categoryEntity = BehaviorRelay<CategoryEntity>(value: CategoryEntity())
    
    init(_ categoryService: CategoryServiceLogic) {
        self.categoryService = categoryService
    }
    
    func fetchCategories() {
        categoryService.categories()
            .subscribe(onSuccess: { [weak self] in
                guard let categoriesModel = $0.data else { return }
                self?.categoryEntity.accept(CategoryEntity(categoriesModel))
            })
            .disposed(by: disposeBag)
    }
}

//
//  MainViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/18.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import PhotosUI
import Foundation

import DesignSystem
import RxRelay
import RxSwift

/// ViewModel에서 사용될 property와 method 정의
protocol MainViewModelProtocol {
    typealias Alert = ((String?, String, String?, ((UIAlertAction) -> Void)?, ((UIAlertAction) -> Void)?) -> ())
    
    var alert: Alert? { get set }
    var present: ((UIViewController) -> ())? { get set }
    var push: ((UIViewController) -> ())? { get set }
    var applyToastModel: PublishRelay<MainViewModel.ApplyToastModel> { get }
    
    var mainDataSource: MainCollectionViewDataSource { get }
    var mainDelegate: MainCollectionViewDelegate { get }

    var toastRequestRelay: PublishRelay<Void> { get }
    var OCRRequestRelay: BehaviorRelay<(SprinkleInformation?, ResponseError)> { get }
    
    var deadlineListUpdated: PublishRelay<Void> { get }
    var categoryListUpdated: PublishRelay<Void> { get }
    var gifticonListUpdated: PublishRelay<Void> { get }
    var isDeadlineDataExist: BehaviorRelay<Bool> { get }

    func presentPhotoPicker()
    func reload()
    func requestPHPhotoLibraryAuthorization()
    func handleAuthorizationStatus(with authorizationStatus: PHAuthorizationStatus)
    func addButtonDidTapped()
}

/// ViewModelProtocol 구현
final class MainViewModel: MainViewModelProtocol {
    struct ApplyToastModel {
        let isSucceeded: Bool
        let message: String?
        let error: Error?
        let image: DesignSystem.DDIPAsset.name?
        
        init(
            isSucceeded: Bool,
            message: String? = nil,
            error: Error? = nil,
            image: DesignSystem.DDIPAsset.name? = nil
        ) {
            self.isSucceeded = isSucceeded
            self.message = message
            self.error = error
            self.image = image
        }
    }
    
    private let disposeBag = DisposeBag()
    private let gifticonService: GifticonService
    private let categoryRepository: CategoryRepositoryLogic
    private let OCRRepository: OCRRepositoryLogic

    var alert: Alert? = nil
    var present: ((UIViewController) -> ())? = nil
    var push: ((UIViewController) -> ())? = nil
    var applyToastModel = PublishRelay<MainViewModel.ApplyToastModel>()
    
    lazy var mainDataSource: MainCollectionViewDataSource = {
        let dataSource = MainCollectionViewDataSource()
        dataSource.buttonDelegate = self
        return dataSource
    }()
    
    lazy var mainDelegate: MainCollectionViewDelegate = {
        let delegate = MainCollectionViewDelegate()
        delegate.collectionViewCellDelegate = self
        return delegate
    }()
    
    var toastRequestRelay = PublishRelay<Void>()
    var OCRRequestRelay: BehaviorRelay<(SprinkleInformation?, ResponseError)> {
        return OCRRepository.sprinkleInformation
    }
    
    var deadlineListUpdated = PublishRelay<Void>()
    var categoryListUpdated = PublishRelay<Void>()
    var gifticonListUpdated = PublishRelay<Void>()
    var isDeadlineDataExist = BehaviorRelay<Bool>(value: false)
    
    init(
        network: Networking,
        repository: CategoryRepositoryLogic,
        OCRRepository: OCRRepositoryLogic
    ) {
        self.gifticonService = GifticonService(network: network)
        self.categoryRepository = repository
        self.OCRRepository = OCRRepository
        
        category()
        bind()
    }
    
    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present?(picker)
    }
    
    func reload() {
        deadlineInfo()
        gifticonList()
    }
}

// MARK: - Private Method

extension MainViewModel {
    private func deadlineInfo() {
        gifticonService.deadline(.init(orderBy: .deadLine, category: .all))
            .subscribe { [weak self] responseModel in
                guard let responseModel = responseModel.data else {
                    return
                }
                let entity = GifticonEntity.init(responseModel)
                self?.mainDataSource.updateDeadLineData(entity.gifticonList)
                self?.deadlineListUpdated.accept(Void())
                self?.isDeadlineDataExist.accept(!entity.gifticonList.isEmpty)
            } onFailure: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    private func category() {
        categoryRepository.fetchCategories()
        
        categoryRepository.categoryEntity
            .subscribe(onNext: { [weak self] list in
                self?.mainDataSource.updateCategoryData(list.all)
                self?.categoryListUpdated.accept(Void())
            })
            .disposed(by: disposeBag)
    }
    
    private func gifticonList() {
        var requestCategory: CommonRequest.CategoryCase {
            if let selectedCategoryIndex = mainDataSource.selectedCategoryIndexPath {
                let categoryModel = mainDataSource.category(selectedCategoryIndex)
                return .init(categoryModel: categoryModel)
            } else {
                return .all
            }
        }
        
        gifticonService.gifticonList(.init(orderBy: .create, category: requestCategory))
            .subscribe { [weak self] responseModel in
                guard let responseModel = responseModel.data else { return }
                let entity = GifticonEntity.init(responseModel)
                self?.mainDataSource.updateGifticonListData(entity.gifticonList)
                self?.gifticonListUpdated.accept(Void())
            } onFailure: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    private func apply(gifticonId: Int) {
        gifticonService.apply(gifticonId)
            .subscribe(onSuccess: { [weak self] _ in
                self?.applyToastModel.accept(.init(isSucceeded: true))
                self?.deadlineInfo()
            }, onFailure: { [weak self] _ in
                self?.applyToastModel.accept(.init(isSucceeded: false))
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        mainDataSource.didTapDeadLineApplyButton
            .subscribe(onNext: { [weak self] in
                self?.apply(gifticonId: $0)
            })
            .disposed(by: disposeBag)
        
        // 마감 시간이 지나고 바로 리스트 재요청 시 그대로 남아있는 이슈가 있음
        // 따라서 delay 500ms를 추가함
        mainDataSource.didDeadLineCountdownTimeOver
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.reload()
            })
            .disposed(by: disposeBag)
    }
    
    private func requestOCR(_ image: UIImage) {
        OCRRepository.request(image)
    }
}

// MARK: - Photo

extension MainViewModel {
    
    /// 사용자에게 접근 권한을 요청하는 메서드
    func requestPHPhotoLibraryAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
            self.handleAuthorizationStatus(with: authorizationStatus)
        }
    }
    
    /// 현재 PHAuthorizationStatus에 따라 분기해서 처리하는 메서드
    func handleAuthorizationStatus(with authorizationStatus: PHAuthorizationStatus) {
        DispatchQueue.main.async {
            switch authorizationStatus {
            case .notDetermined:
                self.requestPHPhotoLibraryAuthorization()
            case .restricted:
                self.alert?(nil, "라이브러리 권한이 제한되어있습니다.", nil, nil, nil)
            case .denied:
                self.alert?(nil, "갤러리 접근 권한이 거부되었습니다.", "권한 설정하러 가기", nil) { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            case .authorized:
                self.presentPhotoPicker()
            case .limited:
                debugPrint("limited")
            @unknown default:
                self.alert?(nil, "관리자에게 문의하세요.", nil, nil, nil)
            }
        }
    }
    
    func addButtonDidTapped() {
        let authorizationStatus: PHAuthorizationStatus
        authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        handleAuthorizationStatus(with: authorizationStatus)
    }
}

// MARK: - Deleagte

extension MainViewModel: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage else {
                    debugPrint("could not load image", error?.localizedDescription ?? "")
                    return
                }
                self?.requestOCR(image)
                self?.toastRequestRelay.accept(())
            }
        }
        picker.dismiss(animated: true)
    }
}

extension MainViewModel: MainCollectionViewCellDelegate {
    func gifticonCellTapped(with id: Int) {
        let applyViewModel = ApplyViewModel(gifticonId: id, network: Network())
        let applyViewController = ApplyViewController(applyViewModel)
        applyViewController.modalPresentationStyle = .fullScreen
        push?(applyViewController)
    }

    func categoryCellTapped(indexPath: IndexPath) {
        mainDataSource.selectedCategoryIndexPath = mainDelegate.selectedCategoryIndexPath
        let category = mainDataSource.category()[indexPath.row]
        
        gifticonService.gifticonList(
            .init(
                orderBy: .create,
                category: categoryToBaseRequestModel(with: category)
            )
        )
        .subscribe(onSuccess: { [weak self] response in
            guard let responseModel = response.data else { return }
            let entity = GifticonEntity.init(responseModel)
            self?.mainDataSource.updateGifticonListData(entity.gifticonList)
            self?.gifticonListUpdated.accept(Void())
        })
        .disposed(by: disposeBag)
    }
    
    private func categoryToBaseRequestModel(with category: Category) -> CommonRequest.CategoryCase {
        switch category {
        case .all:
            return .all
        case .cafe:
            return .cafe
        case .delivery:
            return .delivery
        case .icecream:
            return .icecream
        case .convenienceStore:
            return .convenienceStore
        case .fastfood:
            return .fastfood
        case .voucher:
            return .voucher
        case .etc:
            return .etc
        }
    }
}

extension MainViewModel: GifticonApplyButtonDelegate {
    func applyButtonTapped(with id: Int, categoryImage: DDIPAsset.name, completion: @escaping (Bool) -> ()) {
        gifticonService.apply(id)
            .subscribe { [weak self] applyResponse in
                if applyResponse.code == "S001" { // 응모 성공
                    self?.applyToastModel.accept(.init(
                        isSucceeded: true,
                        message: applyResponse.message,
                        error: nil,
                        image: categoryImage
                    ))
                    completion(true)
                } else { // 응모 실패 - 본인이 등록한 뿌리기 또는 그 외의 경우
                    self?.applyToastModel.accept(.init(
                        isSucceeded: false,
                        message: applyResponse.message,
                        error: nil,
                        image: nil
                    ))
                    completion(false)
                }
            } onFailure: { [weak self] error in // 네트워크 통신 실패
                self?.applyToastModel.accept(.init(isSucceeded: false))
                completion(false)
            }
            .disposed(by: disposeBag)
    }
}

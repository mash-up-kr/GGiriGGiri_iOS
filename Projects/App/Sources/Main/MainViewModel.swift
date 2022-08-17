//
//  MainViewModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/18.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import PhotosUI
import UIKit

import RxRelay
import RxSwift

/// ViewModel에서 사용될 property와 method 정의
protocol MainViewModelProtocol {
    typealias Alert = ((String?, String, String?, ((UIAlertAction) -> Void)?, ((UIAlertAction) -> Void)?) -> ())
    
    var alert: Alert? { get set }
    var present: ((UIViewController) -> ())? { get set }
    var push: ((UIViewController) -> ())? { get set }
    var applyToast: PublishRelay<Bool> { get }
    
    var mainDataSource: MainCollectionViewDataSource { get }
    var mainDelegate: MainCollectionViewDelegate { get }
    
    var deadlineListUpdated: PublishRelay<Void> { get }
    var categoryListUpdated: PublishRelay<Void> { get }
    var gifticonListUpdated: PublishRelay<Void> { get }
    
    var isDeadlineDataExist: Bool { get }
    
    func presentPhotoPicker()
    func requestPHPhotoLibraryAuthorization()
    func handleAuthorizationStatus(with authorizationStatus: PHAuthorizationStatus)
    func addButtonDidTapped()
}

/// ViewModelProtocol 구현
final class MainViewModel: MainViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private let gifticonService: GifticonService
    private let categoryRepository: CategoryRepositoryLogic
    private let OCRRepository: OCRRepositoryLogic
   
    var alert: Alert? = nil
    var present: ((UIViewController) -> ())? = nil
    var push: ((UIViewController) -> ())? = nil
    let applyToast = PublishRelay<Bool>()
    
    let mainDataSource = MainCollectionViewDataSource()
    lazy var mainDelegate: MainCollectionViewDelegate = {
        let delegate = MainCollectionViewDelegate()
        delegate.collectionViewCellDelegate = self
        return delegate
    }()
    
    var deadlineListUpdated = PublishRelay<Void>()
    var categoryListUpdated = PublishRelay<Void>()
    var gifticonListUpdated = PublishRelay<Void>()
    
    var isDeadlineDataExist: Bool
    
    init(
        network: Networking,
        repository: CategoryRepositoryLogic,
        OCRRepository: OCRRepositoryLogic,
        deadlineDataExist: Bool
    ) {
        self.gifticonService = GifticonService(network: network)
        self.categoryRepository = repository
        self.OCRRepository = OCRRepository
        self.isDeadlineDataExist = deadlineDataExist
        
        deadlineInfo()
        category()
        gifticonList()
        bind()
    }
    
    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present?(picker)
    }
    
    private func deadlineInfo() {
        gifticonService.deadline(.init(orderBy: .deadLine, category: .all))
            .subscribe { [weak self] responseModel in
                guard let responseModel = responseModel.data else {
                    return
                }
                let entity = GifticonEntity.init(responseModel)
                self?.mainDataSource.updateDeadLineData(entity.gifticonList)
                self?.deadlineListUpdated.accept(Void())
            } onFailure: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
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
        gifticonService.gifticonList(.init(orderBy: .create, category: .all))
            .subscribe { [weak self] responseModel in
                guard let responseModel = responseModel.data else { return }
                let entity = GifticonEntity.init(responseModel)
                self?.mainDataSource.updateGifticonListData(entity.gifticonList)
                self?.gifticonListUpdated.accept(Void())
            } onFailure: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func apply(gifticonId: Int) {
        gifticonService.apply(gifticonId)
            .subscribe(onSuccess: { [weak self] _ in
                self?.applyToast.accept(true)
                self?.deadlineInfo()
            }, onFailure: { [weak self] _ in
                self?.applyToast.accept(false)
            })
            .disposed(by: disposeBag)
    }
}

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

// MARK: - Private Method

extension MainViewModel {
    private func bind() {
        OCRRepository.sprinkleInformation
            .skip(1)
            .subscribe(onNext: { [weak self] in
                if let sprinkleInformation = $0 {
                    self?.routeToRegisterViewController(sprinkleInformation)
                } else {
                    self?.alert?(
                        "쿠폰 정보 생성 실패",
                        "쿠폰번호를 가져오는 데 실패했습니다.\n더 쉬운 쿠폰사용을 위해 바코드 또는 쿠폰 번호가 잘 보이는 이미지로 다시 시도해주세요!",
                        nil,
                        nil,
                        nil
                    )
                }
            })
            .disposed(by: disposeBag)
        
        mainDataSource.didTapDeadLineApplyButton
            .subscribe(onNext: { [weak self] in
                self?.apply(gifticonId: $0)
            })
            .disposed(by: disposeBag)
        
        mainDataSource.didDeadLineCountdownTimeOver
            .subscribe(onNext: { [weak self] in
                self?.deadlineInfo()
            })
            .disposed(by: disposeBag)
    }
    
    private func requestOCR(_ image: UIImage) {
        OCRRepository.request(image)
    }
    
    private func routeToRegisterViewController(_ information: SprinkleInformation) {
        alert?(nil, "쿠폰 이미지 분석 완료!", nil, nil, { [weak self] _ in
            let viewModel = RegisterGifticonViewModel(
                network: Network(),
                categoryRepository: CategoryRepository(CategoryService(network: Network())),
                information: information
            )
            let registerGifticonViewController = RegisterGifticonViewController(viewModel)
            registerGifticonViewController.modalPresentationStyle = .fullScreen
            self?.present?(registerGifticonViewController)
        })
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
    
    func categoryCellTapped(with category: Category) {
        // TODO: Category에 따라 정렬하기
        debugPrint(#function)
    }
}

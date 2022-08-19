//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import PhotosUI
import UIKit

import DesignSystem
import RxSwift

final class MainViewController: BaseViewController<MainViewModelProtocol> {
    
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
    
    private let disposeBag = DisposeBag()
    
    private let mainView = MainView()
    private var gifticonList = [GifticonCard]()
    private let myBoxButton = TapBarButtons().mybox
    private lazy var navigationBar: DDIPNavigationBar = {
        return  DDIPNavigationBar(
            leftBarItem: nil,
            title: nil,
            rightButtonsItem: [myBoxButton])
    }()

    private let floatingButton = FloatingButton()
    private let toastView = ToastView()
    private let couponIndicatorToastView = DDIPToastView(.imageCheck)

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform.init(scaleX: 3, y: 3)

        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .designSystem(.primaryYellow)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reload()
    }

    override func configure() {
        super.configure()
        
        configureNavigationBar()
        configureCollectionView()
        configureFloatingButton()
    }
    
    override func bind() {
        super.bind()
        
        viewModel.alert = { [weak self] title, message, _, _, action in
            self?.alert(title: title, message: message, okHandler: action)
        }

        viewModel.toastRequestRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.showToastView()
            })
            .disposed(by: disposeBag)

        viewModel.OCRRequestRelay
            .skip(1)
            .subscribe(onNext: { [weak self] sprinkleInformation in
                self?.dismissActivityIndicator()
                if let sprinkleInformation = sprinkleInformation {
                    self?.showRegisterView(information: sprinkleInformation)
                } else {
                    self?.viewModel.alert?(
                        "쿠폰 정보 생성 실패",
                        "쿠폰번호를 가져오는 데 실패했습니다.\n더 쉬운 쿠폰사용을 위해 바코드 또는 쿠폰 번호가 잘 보이는 이미지로 다시 시도해주세요!",
                        nil,
                        nil,
                        nil
                    )
                }
            })
            .disposed(by: disposeBag)

        viewModel.present = { [weak self] viewController in
            self?.present(viewController, animated: true)
        }
        
        viewModel.push = { [weak self] viewController in
            self?.navigationController?.setNavigationBarHidden(true, animated: false)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        Observable.merge(
            viewModel.deadlineListUpdated.map { MainSection.deadLine }.asObservable(),
            viewModel.categoryListUpdated.map { MainSection.category }.asObservable(),
            viewModel.gifticonListUpdated.map { MainSection.gifticonList}.asObservable()
        )
        .subscribe(onNext: { [weak self] section in
            self?.mainView.reloadCollectionViewSection(section)
        })
        .disposed(by: disposeBag)
        
        viewModel.applyToastModel
            .subscribe(onNext: { [weak self] in
                self?.showApplyToast(
                    isSuccessed: $0.isSucceeded,
                    message: $0.message,
                    error: $0.error,
                    image: $0.image ?? .iconRotateLogoCharacterEmpty
                )
                self?.viewModel.reload()
            })
            .disposed(by: disposeBag)
        
        myBoxButton.rx.tap.subscribe(onNext: { [weak self] in
            let myBoxViewModel = MyBoxViewModel(network: Network())
            let myBoxViewController = MyBoxViewController(myBoxViewModel)
            myBoxViewController.modalPresentationStyle = .fullScreen
            self?.viewModel.push?(myBoxViewController)
        })
        .disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        mainView.configureDataSource(viewModel.mainDataSource)
        mainView.configureDelegate(viewModel.mainDelegate)
        
        mainView.isDeadlineDataExist = viewModel.isDeadlineDataExist
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureFloatingButton() {
        let floatingButtonWidth: CGFloat = 48
        let offsetOfX: CGFloat = 16
        let offsetOfY: CGFloat = 48
        
        view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(offsetOfX)
            $0.bottom.equalToSuperview().inset(offsetOfY)
            $0.size.equalTo(floatingButtonWidth)
        }
        
        floatingButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonDidTapped() {
        viewModel.addButtonDidTapped()
    }
}

// MARK: - Toast

extension MainViewController {
    private func showApplyToast(
        isSuccessed: Bool,
        message: String?,
        error: Error?,
        image: DDIPAsset.name
    ) {
        if isSuccessed {
            showSuccessToast(image: image)
            return
        } else {
            if let message = message {
                showFailToast(message: message)
                return
            }
            showNetworkFailToast()
            return
        }
    }
    
    private func showSuccessToast(image: DDIPAsset.name) {
        toastView.configureToastView(with: self.view, style: .apply, image: image)
        toastView.showToastView(with: self.view)
    }
    
    private func showNetworkFailToast() {
        toastView.configureToastView(with: self.view, style: .networkFail, image: .iconRotateLogoCharacterEmpty)
        toastView.showToastView(with: self.view)
    }
    
    private func showFailToast(message: String) {
        toastView.configureToastView(with: self.view, title: "응모 실패", description: message, image: .iconRotateLogoCharacterEmpty)
        toastView.showToastView(with: self.view)
    }
}

// MARK: - Indicator Toast

extension MainViewController {
    private func showToastView() {
        setToastView()
        activityIndicator.startAnimating()
    }

    private func setToastView() {
        couponIndicatorToastView.setDescriptionLabel("쿠폰 이미지 분석 중이에요!\n 잠시만 기다려주세요!")

        self.view.addSubview(couponIndicatorToastView)
        couponIndicatorToastView.addSubview(activityIndicator)

        couponIndicatorToastView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(229)
            $0.height.equalTo(193)
        }

        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-21)
        }
    }

    private func dismissActivityIndicator() {
        activityIndicator.stopAnimating()
        couponIndicatorToastView.removeFromSuperview()
    }

    private func showRegisterView(information: SprinkleInformation) {
        let viewModel = RegisterGifticonViewModel(
            network: Network(),
            categoryRepository: CategoryRepository(CategoryService(network: Network())),
            information: information
        )
        let registerGifticonViewController = RegisterGifticonViewController(viewModel)
        registerGifticonViewController.modalPresentationStyle = .fullScreen
        self.present(registerGifticonViewController, animated: true)
    }
}

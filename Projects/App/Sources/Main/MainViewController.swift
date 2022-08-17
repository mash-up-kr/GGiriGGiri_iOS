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
    
    private let collectionView = MainView()
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

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform.init(scaleX: 3, y: 3)

        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .designSystem(.primaryYellow)
    }

    override func configure() {
        super.configure()
        
        configureNavigationBar()
        configureCollectionView()
        configureFloatingButton()
        
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
        
        viewModel.deadlineListUpdated
            .subscribe (onNext: { [weak self] in
                self?.collectionView.reloadCollectionView()
            })
            .disposed(by: disposeBag)
        
        viewModel.categoryListUpdated
            .subscribe(onNext: { [weak self] in
                self?.collectionView.reloadCollectionView()
            })
            .disposed(by: disposeBag)
        
        viewModel.gifticonListUpdated
            .subscribe (onNext: { [weak self] in
                self?.collectionView.reloadCollectionView()
            })
            .disposed(by: disposeBag)
        
        viewModel.applyToast
            .subscribe(onNext: { [weak self] in
                self?.showApplyToast(isSuccessed: $0)
            })
            .disposed(by: disposeBag)
        
        collectionView.isDeadlineDataExist = viewModel.isDeadlineDataExist
        
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
        collectionView.configureDataSource(viewModel.mainDataSource)
        collectionView.configureDelegate(viewModel.mainDelegate)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
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
    private func showApplyToast(isSuccessed: Bool) {
        toastView.configureToastView(
            with: self.view,
            style: isSuccessed ? .apply : .applyMyGifticonFail,
            image: isSuccessed ? .iconLogoCharacter : .iconRotateLogoCharacterEmpty
        )
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
        couponIndicatorToastView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

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

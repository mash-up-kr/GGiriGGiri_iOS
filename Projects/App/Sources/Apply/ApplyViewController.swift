//
//  ApplyViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
import SnapKit

final class ApplyViewController: BaseViewController<ApplyViewModelProtocol> {
    private let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let applyGifticonView = ApplyGifticonView()
    private let applyButton = DDIPCTAButton()
    private let toastView = ToastView()

    private lazy var navigationBar: DDIPNavigationBar = {
        return DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.back,
            title: "응모하기",
            rightButtonsItem: nil)
    }()

    private func showSuccessToast(category: DDIPAsset.name) {
        toastView.configureToastView(with: self.view, style: .apply, image: category)
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

    private func setApplyCompletButtonState() {
        applyButton.setBackgroundColor(buttonColor: .secondarySkyblue200)
        applyButton.setTitle(title: "응모 완료!")
    }

    private func setFinishButtonState() {
        applyButton.setBackgroundColor(buttonColor: .secondarySkyblue200)
        applyButton.setTitle(title: "응모 마감")
    }

    private func setFailButtonState() {
        applyButton.setBackgroundColor(buttonColor: .secondarySkyblue200)
        applyButton.setTitle(title: "응모 실패")
    }

    override func bind() {
        super.bind()
        applyButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.viewModel.applyButtonTapped()
            })
            .disposed(by: disposeBag)

        viewModel.showToastView
            .bind { [weak self] state in
                guard let message = state.1 else {
                    self?.setFinishButtonState()
                    self?.showNetworkFailToast()
                    self?.toastView.showToastView(with: self?.view ?? UIView())
                    return
                }
                if state.0 == true {
                    self?.setApplyCompletButtonState()
                    self?.showSuccessToast(category: self?.viewModel.detailData.value?.imageName ?? .iconRotateLogoCharacter)
                    self?.toastView.showToastView(with: self?.view ?? UIView())
                } else {
                    self?.setFailButtonState()
                    self?.showFailToast(message: message)
                    self?.toastView.showToastView(with: self?.view ?? UIView())
                }
            }
            .disposed(by: disposeBag)

        viewModel.detailData
            .subscribe(onNext: { [weak self] entity in
                self?.applyGifticonView.setParticipant(participants: entity?.participants ?? 0)
                self?.applyGifticonView.setBrand(name: entity?.brandName ?? "")
                self?.applyGifticonView.setCategory(name: entity?.category ?? "")
                self?.applyGifticonView.setProductName(name: entity?.merchandiseName ?? "")
                self?.applyGifticonView.setExpirationDate(name: entity?.expiredAt ?? "")
                self?.applyGifticonView.setImageIcon(imageName: entity?.imageName ?? .iconLogoCharacter)

                // TODO: 형변환 및 로직 필요
                //            self.applyGifticonView.setCountdownDate(date: entity.sprinkleAt)

            })
            .disposed(by: disposeBag)
    }

    override func setLayout() {
        super.setLayout()
        
        view.addSubviews(with: [navigationBar, scrollView, applyButton])
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        scrollContentView.addSubview(applyGifticonView)
        applyButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        gifticonViewLayout()
    }
    
    private func gifticonViewLayout() {
        applyGifticonView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(37)
        }
    }
    
    override func configure() {
        super.configure()
        
        configureNavigationBar()
        
        view.backgroundColor = .designSystem(.neutralWhite)

        applyButton.setBackgroundColor(buttonColor: .secondaryBlue)
        applyButton.setTitle(title: "지금 당장 응모할게요!")

        // TODO: 바꿔야할 로직
        applyGifticonView.setCountdownDate(date: Date())
    }

    private func configureNavigationBar() {
        navigationBar.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}

//
//  RegisterGifticonViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
import SnapKit

final class RegisterGifticonViewController: BaseViewController<RegisterGifticonViewModelProtocol> {
    private lazy var navigationBar: DDIPNavigationBar = {
        return DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.cancel,
            title: "기프티콘 등록",
            rightButtonsItem: nil)
    }()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let registerGifticonView = RegisterGifticonView()
    public var giftionImage = UIImage()
    private let registerButton = DDIPCTAButton()
    
    private let disposeBag = DisposeBag()
    
    override func configure() {
        super.configure()
        view.backgroundColor = .designSystem(.neutralWhite)
        scrollView.delegate = self
        
        configureNavigationBar()
        
        registerGifticonView.registerGiftionImageView.imageView.image = giftionImage
        registerGifticonView.registerGiftionImageView.delegate = self
        registerGifticonView.showTimeSelectPicker = { [weak self] in
            self?.showPicker()
        }
        
        registerButton.setTitle(title: "내용을 입력해야 뿌릴 수 있어요")
        registerButton.setBackgroundColor(buttonColor: .secondarySkyblue200)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willShowKeyboard),
            name: UIWindow.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willHideKeyboard),
            name: UIWindow.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func configureNavigationBar() {
        navigationBar.leftButtonTapEvent
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(with: [navigationBar, scrollView, registerGifticonView, registerButton])
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        registerButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        setContentViewLayout()
    }
}

// MARK: - Layout

extension RegisterGifticonViewController {
    private func setContentViewLayout() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        contentView.addSubview(registerGifticonView)
        registerGifticonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Keyboard Observer

extension RegisterGifticonViewController {
    @objc
    private func willShowKeyboard(_ notification: Notification) {
        handleScrollView(notification, isKeyboardShow: true)
    }
    
    @objc
    private func willHideKeyboard(_ notification: Notification) {
        handleScrollView(notification, isKeyboardShow: false)
    }
    
    private func handleScrollView(_ notification: Notification, isKeyboardShow: Bool) {
        guard
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        else { return }
        
        let insetValue = isKeyboardShow ? keyboardFrame.cgRectValue.height - view.safeAreaInsets.bottom: 0
        let contentInsetValue: CGFloat = isKeyboardShow ? 20 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: contentInsetValue, right: 0)
        
        registerButton.snp.updateConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(insetValue + 34)
        }
        
        UIView.animate(withDuration: keyboardAnimationDuration.doubleValue) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: - UIScrollViewDelegate

extension RegisterGifticonViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - Picker

extension RegisterGifticonViewController {
    func showPicker() {
        let pickerViewController = PickerViewController(PickerViewModel(dataSourceType: .title(
            // TODO: - 임의로 넣은 피커 데이터. 확인 필요
            ["30분", "1시간", "1시간30분", "2시간", "2시간 30분"]
        ), didSelectItem: { [weak self] time in
            guard let time = time as? String else { return }
            self?.registerGifticonView.updateTime(time)
        }))
        present(pickerViewController, animated: false)
    }
}

extension RegisterGifticonViewController: RegisterGifticonImageViewButtonDelegate {
    func originalButtonTapped() {
        let gifticonImageViewController = GiftionImageViewController()
        gifticonImageViewController.giftionImageView.image = giftionImage
        present(gifticonImageViewController, animated: true)
    }
}

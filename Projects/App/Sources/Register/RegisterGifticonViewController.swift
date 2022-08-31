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
    private let registerButton = DDIPCTAButton()
    
    private let toastView = ToastView()
    
    private let disposeBag = DisposeBag()
    
    override func configure() {
        super.configure()
        view.backgroundColor = .designSystem(.neutralWhite)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        
        configureNavigationBar()
        
        configureGifiticonInfoView()
        
        configureKeyboardOberver()
        
        configureRegisterButton()
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
    
    override func bind() {
        super.bind()
        viewModel.categoryRepository?.categoryEntity
            .skip(1)
            .subscribe(onNext: { [weak self] in
                self?.registerGifticonView.updateCategories($0.expectAll)
            })
            .disposed(by: disposeBag)
        
        viewModel.informationValidation
            .subscribe(onNext: { [weak self] in
                self?.updateRegisterButton(isValidated: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel.toast
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .registerSuccess:
                    self?.showRegisterSuccessToast()
                    self?.dismissRegister()
                case .registerFail:
                    self?.showRegisterFailToast()
                }
                self?.registerButton.isEnabled = true
            })
            .disposed(by: disposeBag)
        
        viewModel.informationRelay
            .subscribe(onNext: { [weak self] in
                guard let information = $0 else { return }
                self?.registerGifticonView.updateInformation(information)
            })
            .disposed(by: disposeBag)
        
        registerGifticonView.selectedCategoryIndex = { [weak self] in
            self?.viewModel.update(.category($0))
        }
        
        registerGifticonView.updateBarandName = { [weak self] in
            self?.viewModel.update(.brandName($0))
        }
        
        registerGifticonView.updateProductName = { [weak self] in
            self?.viewModel.update(.productName($0))
        }
        
        registerGifticonView.updateExpirationDate = { [weak self] in
            self?.viewModel.update(.expirationDate($0))
        }
        
        registerGifticonView.updateDeadLineMinute = { [weak self] in
            self?.viewModel.update(.deadlineMinute($0))
        }
        
        registerButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                // TODO: - 인디케이터로 변경할것
                self?.registerButton.isEnabled = false
                self?.viewModel.requestRegister()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateRegisterButton(isValidated: Bool) {
        registerButton.isEnabled = isValidated
        updateRegisterButton(isValidated)
    }
}

// MARK: - Configure

extension RegisterGifticonViewController {
    private func configureNavigationBar() {
        navigationBar.leftButtonTapEvent
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureKeyboardOberver() {
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
    
    private func configureGifiticonInfoView() {
        registerGifticonView.updateGifticonImage(viewModel.gifticonImage)
        registerGifticonView.originalImageDelegate(self)
        registerGifticonView.showTimeSelectPicker = { [weak self] in
            self?.showPicker()
        }
    }
    
    private func configureRegisterButton() {
        updateRegisterButton()
    }
    
    private func updateRegisterButton(_ isValidate: Bool = false) {
        registerButton.setTitle(title: isValidate ? "기프티콘을 뿌려볼까요?" : "내용을 입력해야 뿌릴 수 있어요")
        registerButton.setBackgroundColor(buttonColor: isValidate ? .secondaryBlue : .secondarySkyblue200)
    }
    
    private func dismissRegister() {
        // TODO: 임시로 2초 뒤에 동작하게함, Toast의 completion으로 넘겨야함
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            self?.dismiss(animated: true)
        }
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(insetValue)
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
    private func showPicker() {
        var times = [String]()
        for time in RegisterTime.allCases {
            times.append(time.rawValue)
        }
        let pickerViewController = PickerViewController(PickerViewModel(dataSourceType: .title(
            times
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
        gifticonImageViewController.giftionImageView.image = viewModel.gifticonImage
        present(gifticonImageViewController, animated: true)
    }
}

// MARK: - Toast

extension RegisterGifticonViewController {
    private func showRegisterSuccessToast() {
        toastView.configureToastView(with: self.view, style: .register, image: .iconLogoCharacter)
        toastView.showToastView(with: self.view)
    }
    
    private func showRegisterFailToast() {
        toastView.configureToastView(with: self.view, style: .registerFail, image: .iconRotateLogoCharacterEmpty)
        toastView.showToastView(with: self.view)
    }
}

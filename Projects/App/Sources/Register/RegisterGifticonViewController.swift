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
        
        configureNavigationBar()
        
        registerGifticonView.registerGiftionImageView.imageView.image = giftionImage
        registerGifticonView.registerGiftionImageView.delegate = self
        
        registerButton.setTitle(title: "내용을 입력해야 뿌릴 수 있어요")
        registerButton.setBackgroundColor(buttonColor: .secondarySkyblue200)
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

extension RegisterGifticonViewController: RegisterGifticonImageViewButtonDelegate {
    func originalButtonTapped() {
        let gifticonImageViewController = GiftionImageViewController()
        gifticonImageViewController.giftionImageView.image = giftionImage
        present(gifticonImageViewController, animated: true)
    }
}

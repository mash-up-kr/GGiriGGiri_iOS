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

final class RegisterGifticonViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private let registerGifticonView = RegisterGifticonView()
    private lazy var navigationBar: DDIPNavigationBar = {
        return DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.cancel,
            title: "기프티콘 등록",
            rightButtonsItem: nil)
    }()
    
    public var giftionImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .ddip(.neutralWhite)
        
        configureNavigationBar()
        configure()
    }
    
    private func configure() {
        view.addSubview(registerGifticonView)
        
        registerGifticonView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        registerGifticonView.registerGiftionImageView.imageView.image = giftionImage
        registerGifticonView.registerGiftionImageView.delegate = self
    }
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        navigationBar.leftButtonTapEvent.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}


extension RegisterGifticonViewController: RegisterGifticonImageViewButtonDelegate {
    func originalButtonTapped() {
        let gifticonImageViewController = GiftionImageViewController()
        gifticonImageViewController.giftionImageView.image = giftionImage
        present(gifticonImageViewController, animated: true)
    }
}

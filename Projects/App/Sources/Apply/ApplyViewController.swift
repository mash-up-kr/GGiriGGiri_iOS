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
    
    private lazy var navigationBar: DDIPNavigationBar = {
        return DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.back,
            title: "응모하기",
            rightButtonsItem: nil)
    }()
    
    private let applyGifticonView = ApplyGifticonView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .designSystem(.neutralWhite)
    }
    
    override func setLayout() {
        super.setLayout()
        
        view.addSubviews(with: [applyGifticonView])
        
        applyGifticonView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        configureNavigationBar()
        
        applyGifticonView.delegate = self
    }
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        navigationBar.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}

extension ApplyViewController: ApplyGifticonViewButtonDelegate {
    func applyButtonTapped(completion: @escaping () -> Void) {
        alert(message: "응모 완료~!", okHandler: { _ in
            completion()
        })
    }
}

//
//  ResultViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift
import SnapKit

final class ResultViewController: BaseViewController<ResultViewModelProtocol> {

    private let disposeBag = DisposeBag()
    
    private lazy var navigationBar: DDIPNavigationBar = {
        return  DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.back,
            title: "결과 확인",
            rightButtonsItem: nil)
    }()
    
    private let resultView = ResultView()
    private let toastView = DDIPToastView()
    private let wrapperView = UIView()
    private let dimView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setLayout() {
        super.setLayout()
        
        view.addSubview(resultView)
        
        resultView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configure() {
        super.configure()
        
        view.backgroundColor = .designSystem(.primaryYellow)
        
        configureNavigationBar()
        
        navigationBar.leftButtonTapEvent.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        resultView.delegate = self
        resultView.type = viewModel.type
        resultView.iconDelegate = self
    }
    
    private func configureNavigationBar() {
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension ResultViewController: ResultViewButtonDelegate {
    func homeButtonTapped() {
        dismiss(animated: true)
    }
    
    func saveButtonTapped() {
        // TODO: 서버에서 받아온 이미지로 저장해줘야함
        guard let image = UIImage(systemName: "pencil") else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(gifticonImageSaved), nil)
    }
    
    @objc private func gifticonImageSaved(image: UIImage, error: Error?, context: UnsafeRawPointer) {
        let toastView = ToastView()
        toastView.configureToastView(with: self.view, style: .save, image: .iconLogoCharacter)
        toastView.showToastView(with: self.view)
    }
}

extension ResultViewController: GifticonIconViewDelegate {
    func gifticonIconDidTapped() {
        let gifticonImageViewController = GiftionImageViewController()
        // TODO: 서버에서 받아온 이미지로 보여줘야함
        gifticonImageViewController.giftionImageView.image = UIImage(systemName: "pencil")
        present(gifticonImageViewController, animated: true)
    }
}

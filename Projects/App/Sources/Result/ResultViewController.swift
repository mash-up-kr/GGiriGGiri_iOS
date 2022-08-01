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

    var type: GifticonResult = .lose
    private let disposeBag = DisposeBag()
    
    private lazy var navigationBar: DDIPNavigationBar = {
        return  DDIPNavigationBar(
            leftBarItem: DDIPNavigationBar.BarItem.back,
            title: "결과 확인",
            rightButtonsItem: nil)
    }()
    
    private let resultView = ResultView()
    
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
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        resultView.delegate = self
        resultView.type = viewModel.type
        resultView.winView.iconView.delegate = self
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
        guard let image = UIImage(named: "img_gosim3") else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(gifticonImageSaved), nil)
    }
    
    @objc private func gifticonImageSaved(image: UIImage, error: Error?, context: UnsafeRawPointer) {
        alert(message: "저장완료")
    }
}

extension ResultViewController: GifticonIconViewDelegate {
    func gifticonIconDidTapped() {
        let gifticonImageViewController = GiftionImageViewController()
        // TODO: 서버에서 받아온 이미지로 보여줘야함
        gifticonImageViewController.giftionImageView.image = UIImage(named: "img_gosim1")
        present(gifticonImageViewController, animated: true)
    }
}

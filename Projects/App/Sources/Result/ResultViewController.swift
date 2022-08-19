//
//  ResultViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import Kingfisher
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
    private let toastView = DDIPToastView(.result)
    private var imageUrl = ""
    
    private var gifticonImage: UIImage? {
        didSet {
            saveImage()
        }
    }
    
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
    
    override func bind() {
        super.bind()
        
        viewModel.couponInfo
            .subscribe(onNext: { [weak self] entity in
                guard let entity = entity else { return }
                self?.resultView.winView.configure(gifticon:
                                                Gifticon(id: 0,
                                                         brand: entity.brandName,
                                                         name: entity.merchandiseName,
                                                         expirationDate: entity.expiredAt.format(.yearMonthDay),
                                                         category: Category(rawValue: entity.category) ?? .all
                                                        ))
                self?.resultView.imageUrl = entity.imageURL
                self?.imageUrl = entity.imageURL
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
}

extension ResultViewController: ResultViewButtonDelegate {
    
    func homeButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func saveButtonTapped(completion: @escaping (Bool) -> ()) {
        guard let imageUrl = URL(string: imageUrl) else { return }
        
        KingfisherManager.shared.retrieveImage(with: imageUrl, completionHandler: { [weak self] result in
            switch(result) {
            case .success(let imageResult):
                let image = imageResult.image.withRenderingMode(.alwaysOriginal)
                self?.gifticonImage = image
                completion(true)
            case .failure:
                completion(false)
            }
        })
    }
 
    private func saveImage() {
        guard let image = gifticonImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(gifticonImageSaved), nil)
    }
    
    @objc private func gifticonImageSaved(image: UIImage, error: Error?, context: UnsafeRawPointer) {
        
        let toastView = ToastView()
        
        if error == nil {
            toastView.configureToastView(with: self.view, style: .save, image: .iconLogoCharacter)
        } else {
            toastView.configureToastView(with: self.view, style: .saveFail, image: .iconRotateLogoCharacterEmpty)
        }
        toastView.showToastView(with: self.view)
    }
    
    func showFailToastView() {
        let toastView = ToastView()
        toastView.configureToastView(with: self.view, style: .saveFail, image: .iconRotateLogoCharacterEmpty)
        toastView.showToastView(with: self.view)
    }
}

extension ResultViewController: GifticonIconViewDelegate {
    func gifticonIconDidTapped() {
        let gifticonImageViewController = GiftionImageViewController()
        guard let url = URL(string: imageUrl) else { return }
        gifticonImageViewController.giftionImageView.kf.setImage(with: url)
        present(gifticonImageViewController, animated: true)
    }
}

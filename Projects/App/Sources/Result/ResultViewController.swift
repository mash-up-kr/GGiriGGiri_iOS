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
    private let toastView = DDIPToastView(style: .init(titleOption: .save,
                                                       descriptionOption: .save,
                                                       imageIcon: "img_logos"))
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
            self?.dismiss(animated: true)
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
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        dimView.addSubview(toastView)
        wrapperView.addSubview(dimView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopupView(_:)))
        wrapperView.addGestureRecognizer(tapGesture)
        wrapperView.isUserInteractionEnabled = true
        
        view.addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        toastView.snp.makeConstraints {
            $0.width.equalTo(289)
            $0.height.equalTo(295)
            $0.centerX.centerY.equalToSuperview()
        }

        toastView.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            UIView.transition(with: self.view, duration: 0.3, options: [.curveEaseInOut], animations: {
                self.toastView.alpha = 1
            }, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            UIView.transition(with: self.view, duration: 0.3, options: [.curveEaseInOut], animations: {
                self.toastView.alpha = 0
                self.dimView.removeFromSuperview()
                self.wrapperView.removeFromSuperview()
            }, completion: nil)
        }
    }
    
    @objc private func dismissPopupView(_ gesture: UITapGestureRecognizer) {
        toastView.alpha = 0
        dimView.removeFromSuperview()
        wrapperView.removeFromSuperview()
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

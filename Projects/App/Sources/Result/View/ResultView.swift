//
//  ResultView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

protocol ResultViewButtonDelegate: AnyObject {
    func homeButtonTapped()
    func saveButtonTapped(completion: @escaping (Bool) -> ())
    func showFailToastView()
}

final class ResultView: BaseView {
    
    weak var iconDelegate: GifticonIconViewDelegate?
    weak var delegate: ResultViewButtonDelegate?
    var type: GifticonResult = .lose {
        didSet {
            switch type {
            case .win:
                winView.isHidden = false
                loseView.isHidden = true
                button.setTitle(title: "갤러리에 저장")
                button.setBackgroundColor(buttonColor: .secondaryBlue)
            case .lose:
                winView.isHidden = true
                loseView.isHidden = false
                button.setTitle(title: "홈으로 이동")
                button.setBackgroundColor(buttonColor: .secondaryBlue)
            case .progress:
                break
            }
        }
    }
    
    private(set) var winView = WinView()
    private let loseView = LoseView()
    var imageUrl: String?
    
    private let button = DDIPCTAButton()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [loseView, winView, button])
        
        loseView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(button.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        winView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(button.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .clear
        
        button.addTarget(self, action: #selector(homeButtonTapped(_:)), for: .touchUpInside)
        
        winView.iconView.delegate = self
        iconDelegate = winView.iconView.delegate
    }
    
    @objc private func homeButtonTapped(_ sender: UIButton) {
        switch type {
        case .win:
            guard let imageUrl = imageUrl else { return }

            delegate?.saveButtonTapped(completion: { [weak self] saved in
                if saved {
                    self?.button.setBackgroundColor(buttonColor: .secondarySkyblue200)
                    self?.button.setTitle(title: "저장 완료")
                    self?.button.isEnabled = false
                } else {
                    self?.delegate?.showFailToastView()
                }
            })
        case .lose:
            delegate?.homeButtonTapped()
        case .progress:
            break
        }
    }
}

extension ResultView: GifticonIconViewDelegate {
    func gifticonIconDidTapped() {
        iconDelegate?.gifticonIconDidTapped()
    }
}

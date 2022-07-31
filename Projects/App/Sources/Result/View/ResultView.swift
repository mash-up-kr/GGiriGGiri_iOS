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
}

final class ResultView: BaseView {
    
    weak var delegate: ResultViewButtonDelegate?
    var type: GifticonResult = .lose
    
    private let winView = WinView()
    private let loseView = LoseView()
    
    private let button = DDIPCTAButton(
        style: .init(buttonColor: .designSystem(.secondaryBlue) ?? .white,
                     title: "홈으로 이동"))
    
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
        
        switch type {
        case .win:
            winView.isHidden = false
            loseView.isHidden = true
        case .lose:
            winView.isHidden = true
            loseView.isHidden = false
        }
    }
    
    @objc private func homeButtonTapped(_ sender: UIButton) {
        delegate?.homeButtonTapped()
    }
}

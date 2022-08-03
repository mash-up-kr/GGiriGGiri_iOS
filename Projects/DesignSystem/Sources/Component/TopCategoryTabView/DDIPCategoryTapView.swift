//
//  DDIPCategoryTapView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//


import UIKit

import RxCocoa
import RxSwift

public class DDIPCategoryTapView: UIView, AddViewsable {
    public enum TapCategoryOptions {
        case box, alarm

        var info: (leftTitle: String, rightTitle: String) {
            switch self {
            case .box:
                return ("응모 BOX", "등록 BOX")
            case .alarm:
                return ("결과 알림", "활동 알림")
            }
        }
    }
    
    public let leftTabButton: UIButton = UIButton()
    public let rightTapButton: UIButton = UIButton()
    public let moveBarView: UIView = UIView()
    
    private let disposeBag = DisposeBag()
    
    public let leftButtonTapEvent = PublishRelay<Void>()
    public let rightButtonTapEvent = PublishRelay<Void>()
    
    public init() {
        super.init(frame: .zero)
        setView()
        setLayout()
        setAttribute()
        bind()
        setButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setLeftTitle(_ title: TapCategoryOptions) {
        self.leftTabButton.setTitle(title.info.leftTitle, for: .normal)
    }

    public func setRightTitle(_ title: TapCategoryOptions) {
        self.rightTapButton.setTitle(title.info.rightTitle, for: .normal)
    }
    
    private func setAttribute() {
        self.moveBarView.backgroundColor = .designSystem(.neutralBlack)

        self.leftTabButton.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._16)
        self.rightTapButton.titleLabel?.font = .designSystem(.pretendard, family: .regular, size: ._16)
        
        self.leftTabButton.setTitleColor(.designSystem(.neutralBlack), for: .normal)
        self.rightTapButton.setTitleColor(.designSystem(.neutralBlack), for: .normal)
    }
    
    private func setButtons() {
        self.leftTabButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        self.rightTapButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    private func setView() {
        self.leftTabButton.translatesAutoresizingMaskIntoConstraints = false
        self.rightTapButton.translatesAutoresizingMaskIntoConstraints = false
        self.moveBarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([leftTabButton, rightTapButton, moveBarView])
    }
    
    @objc private func leftButtonTapped() {
        self.rightTapButton.titleLabel?.font = .designSystem(.pretendard, family: .regular, size: ._16)
        self.leftTabButton.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._16)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.moveBarView.frame = CGRect(
                x: self.leftTabButton.frame.origin.x,
                y: self.leftTabButton.frame.origin.y + self.leftTabButton.frame.height,
                width: self.moveBarView.frame.width,
                height: self.moveBarView.frame.height
            )
        }
    }
    
    @objc private func rightButtonTapped() {
        self.leftTabButton.titleLabel?.font = .designSystem(.pretendard, family: .regular, size: ._16)
        self.rightTapButton.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._16)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.moveBarView.frame = CGRect(
                x: self.rightTapButton.frame.origin.x,
                y: self.rightTapButton.frame.origin.y + self.rightTapButton.frame.height,
                width: self.moveBarView.frame.width,
                height: self.moveBarView.frame.height
            )
        }
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 390),
            self.heightAnchor.constraint(equalToConstant: 38)
        ])

        NSLayoutConstraint.activate([
            leftTabButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            leftTabButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            leftTabButton.trailingAnchor.constraint(equalTo: self.rightTapButton.leadingAnchor, constant: -30),
            leftTabButton.bottomAnchor.constraint(equalTo: moveBarView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            rightTapButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            rightTapButton.bottomAnchor.constraint(equalTo: self.moveBarView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            moveBarView.leadingAnchor.constraint(equalTo: self.leftTabButton.leadingAnchor),
            moveBarView.trailingAnchor.constraint(equalTo: self.leftTabButton.trailingAnchor),
            moveBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            moveBarView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    private func bind() {
        leftTabButton.rx.tap.bind(to: self.leftButtonTapEvent)
            .disposed(by: disposeBag)
        rightTapButton.rx.tap.bind(to: self.rightButtonTapEvent)
            .disposed(by: disposeBag)
    }
}

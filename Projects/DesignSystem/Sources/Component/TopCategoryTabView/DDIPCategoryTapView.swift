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
import SnapKit

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
        self.snp.makeConstraints {
            $0.height.equalTo(38)
        }

        leftTabButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalTo(rightTapButton.snp.leading).inset(-30)
            $0.bottom.equalTo(moveBarView.snp.top)
        }

        rightTapButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalTo(moveBarView.snp.top)
        }

        moveBarView.snp.makeConstraints {
            $0.leading.equalTo(leftTabButton.snp.leading)
            $0.trailing.equalTo(leftTabButton.snp.trailing)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    private func bind() {
        leftTabButton.rx.tap.bind(to: self.leftButtonTapEvent)
            .disposed(by: disposeBag)
        rightTapButton.rx.tap.bind(to: self.rightButtonTapEvent)
            .disposed(by: disposeBag)
    }
}

// MARK: - 외부 주입 메서드

extension DDIPCategoryTapView {
    public func setLeftTitle(_ title: TapCategoryOptions) {
        self.leftTabButton.setTitle(title.info.leftTitle, for: .normal)
    }

    public func setRightTitle(_ title: TapCategoryOptions) {
        self.rightTapButton.setTitle(title.info.rightTitle, for: .normal)
    }

    public func tapLeftButton() {
        leftButtonTapped()
    }

    public func tapRightButton() {
        rightButtonTapped()
    }
}

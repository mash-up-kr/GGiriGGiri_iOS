//
//  DDIPCategoryTapView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//


import UIKit

import SnapKit
import RxCocoa
import RxSwift

public class DDIPCategoryTapView: UIView, AddViewsable {
    public let style: DDIPCategoryTapViewStyle
    
    public let leftTabButton: UIButton = UIButton()
    public let rightTapButton: UIButton = UIButton()
    public let moveBarView: UIView = UIView()
    
    private let disposeBag = DisposeBag()
    
    public let leftButtonTapEvent = PublishRelay<Void>()
    public let rightButtonTapEvent = PublishRelay<Void>()
    
    public init(
        frame: CGRect = .zero,
        style: DDIPCategoryTapViewStyle
    ) {
        self.style = style
        super.init(frame: frame)
        setTapView()
        setUI()
        setAttribute()
        bind()
        setButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {
        self.moveBarView.backgroundColor = UIColor.black
        self.leftTabButton.setTitle(self.style.leftTitle, for: .normal)
        self.rightTapButton.setTitle(self.style.rightTitle, for: .normal)
        
        self.leftTabButton.titleLabel?.font = .pretendard(family: .regular, size: ._16)
        self.rightTapButton.titleLabel?.font = .pretendard(family: .regular, size: ._16)
        
        self.leftTabButton.setTitleColor(.black, for: .normal)
        self.rightTapButton.setTitleColor(.black, for: .normal)
    }
    
    private func setButtons() {
        self.leftTabButton.addTarget(self, action: #selector(selectLeftButton), for: .touchUpInside)
        self.rightTapButton.addTarget(self, action: #selector(selectRightButton), for: .touchUpInside)
    }
    
    private func setTapView() {
        self.leftTabButton.translatesAutoresizingMaskIntoConstraints = false
        self.rightTapButton.translatesAutoresizingMaskIntoConstraints = false
        self.moveBarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([leftTabButton, rightTapButton, moveBarView])
    }
    
    @objc private func selectLeftButton() {
        UIView.animate(withDuration: 0.3) {
            self.moveBarView.frame = CGRect(
                x: self.leftTabButton.frame.origin.x,
                y: self.leftTabButton.frame.origin.y + self.leftTabButton.frame.height,
                width: self.moveBarView.frame.width,
                height: self.moveBarView.frame.height
            )
            self.layoutIfNeeded()
        } completion: { _ in
        }
    }
    
    @objc private func selectRightButton() {
        UIView.animate(withDuration: 0.3) {
            self.moveBarView.frame = CGRect(
                x: self.rightTapButton.frame.origin.x,
                y: self.rightTapButton.frame.origin.y + self.rightTapButton.frame.height,
                width: self.moveBarView.frame.width,
                height: self.moveBarView.frame.height
            )
            self.layoutIfNeeded()
        } completion: { _ in
        }
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            leftTabButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            leftTabButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            leftTabButton.trailingAnchor.constraint(equalTo: self.rightTapButton.leadingAnchor, constant: -30),
            leftTabButton.bottomAnchor.constraint(equalTo: moveBarView.topAnchor),
            
            rightTapButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            rightTapButton.bottomAnchor.constraint(equalTo: self.moveBarView.topAnchor),
            
            moveBarView.leadingAnchor.constraint(equalTo: self.leftTabButton.leadingAnchor),
            moveBarView.trailingAnchor.constraint(equalTo: self.leftTabButton.trailingAnchor),
            moveBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            moveBarView.heightAnchor.constraint(equalToConstant: 2),
            
            self.widthAnchor.constraint(equalToConstant: 390),
            self.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    private func bind() {
        leftTabButton.rx.tap.bind(to: self.leftButtonTapEvent)
            .disposed(by: disposeBag)
        rightTapButton.rx.tap.bind(to: self.rightButtonTapEvent)
            .disposed(by: disposeBag)
    }
}

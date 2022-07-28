//
//  DDIPNavigationBar.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/01.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

public class DDIPNavigationBar: UIView {
    public enum BarItem {
        case back
        case cancel
        
        var icon: UIImage? {
            switch self {
            case .back:
                return .designSystem(.iconAngelBracket24)
            case .cancel:
                return .designSystem(.iconCrossX24)
            }
        }
    }
    
    private let titleLabel: UILabel = UILabel()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    private var rightButtonsItems: [UIButton]?
    private let leftButtonItem = UIButton()
    
    private let disposeBag = DisposeBag()
    
    public let leftButtonTapEvent = PublishRelay<Void>()
    
    public init(
        leftBarItem: BarItem? = nil,
        title: String? = nil,
        rightButtonsItem: [UIButton]? = nil
    ) {
        self.leftBarItem = leftBarItem
        self.titleLabel.text = title
        self.rightButtonsItems = rightButtonsItem
    
        super.init(frame: .zero)
        
        setAttribute()
        setButtons()
        layout()
        bind()
    }
        
    public var title: String? {
        didSet { self.titleLabel.text = title }
    }
    
    public var leftBarItem: BarItem? {
        didSet { leftButtonItem.setImage(leftBarItem?.icon, for: .normal) }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Fatal Error")
    }
    
    private func layout() {
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addSubview(leftButtonItem)
        leftButtonItem.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        guard let items = rightButtonsItems, items.isEmpty == false else { return }
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setAttribute() {
        leftButtonItem.setImage(leftBarItem?.icon, for: .normal)
    }
    
    private func setButtons() {
        guard let buttons = rightButtonsItems else { return }
        buttons.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func bind() {
        leftButtonItem.rx.tap.bind(to: self.leftButtonTapEvent)
            .disposed(by: disposeBag)
    }
}

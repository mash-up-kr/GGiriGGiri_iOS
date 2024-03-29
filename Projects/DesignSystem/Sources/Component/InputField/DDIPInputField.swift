//
//  DDIPInputField.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/20.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxRelay

/// DDIP DesignSystem InputField
public final class DDIPInputField: UIView {
    public enum State {
        case normal
        case error
    }
    
    // MARK: - UI Property
    
    private let wrapper: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .designSystem(.neutralGray100)
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let textfield: UITextField = {
        let textfield = UITextField()
        textfield.font = .designSystem(.pretendard, family: .regular, size: ._14)
        textfield.backgroundColor = .clear
        return textfield
    }()
    
    // MARK: - Binding Property
    
    private var disposeBag = DisposeBag()
    
    public let state = PublishRelay<DDIPInputField.State>()
    public let textRelay = BehaviorRelay<String?>(value: nil)
    
    // MARK: - Property Observers
    
    private var _state: State = .normal {
        didSet {
            update(which: .state)
        }
    }
    
    private var placeholder: String? {
        didSet {
            update(which: .placeholder)
        }
    }
    
    private var text: String? {
        didSet {
            update(which: .text)
        }
    }
    
    private var condition: ((String?) -> (Bool))? = nil {
        didSet {
            bind()
        }
    }
    
    // MARK: - Initializer
    
    public init(placeholder: String? = nil, condition: ((String?) -> (Bool))? = nil) {
        super.init(frame: .zero)
        configure()
        layout()
        bind()
        
        update(placeholder: placeholder)
        if let condition = condition {
            update(condition: condition)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension DDIPInputField {
    private func configure() {
        textfield.delegate = self
    }
}

// MARK: - Layout

extension DDIPInputField {
    private func layout() {
        addSubview(wrapper)
        snp.makeConstraints {
            $0.height.equalTo(54)
        }
        wrapper.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        wrapper.addSubview(textfield)
        textfield.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(17)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Binding

extension DDIPInputField {
    private func bind() {
        disposeBag = DisposeBag()
        
        textfield.rx.text
            .distinctUntilChanged()
            .bind(to: textRelay)
            .disposed(by: disposeBag)
        
        if condition != nil {
            bindCheck()
        }
    }
    
    private func bindCheck() {
        textfield.rx.text
            .withUnretained(self)
            .skip(1)
            .subscribe(onNext: { (owner, text) in
                let state = owner.check(text)
                owner.update(state: state)
                owner.state.accept(state)
            })
            .disposed(by: disposeBag)
        
        textfield.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                owner.update(which: .state)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func check(_ text: String?) -> State {
        guard let condition = condition else {
            return .error
        }
        if condition(text) {
            return .normal
        } 
        return .error
    }
}

extension DDIPInputField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

// MARK: - Private Update

extension DDIPInputField {
    private enum Update {
        case state
        case placeholder
        case text
    }
    
    private func update(which: Update) {
        switch which {
        case .state:
            updateColor()
        case .placeholder:
            updatePlaceHolder()
        case .text:
            updateText()
        }
    }
    
    private func updateColor() {
        switch _state {
        case .normal:
            wrapper.layer.borderColor = UIColor.clear.cgColor
            textfield.textColor = .designSystem(.neutralBlack)
        case .error:
            wrapper.layer.borderColor = UIColor.designSystem(.dangerRaspberry)?.cgColor
            textfield.textColor = .designSystem(.dangerRaspberry)
        }
    }
    
    private func updatePlaceHolder() {
        textfield.placeholder = placeholder
    }
    
    private func updateText() {
        textfield.text = text
    }
}

// MARK: - Public Update

extension DDIPInputField {
    public func update(state: State) {
        _state = state
    }
    
    public func update(placeholder: String?) {
        self.placeholder = placeholder
    }
    
    public func update(condition: ((String?) -> Bool)?) {
        guard let condition = condition else {
            disposeBag = DisposeBag()
            return
        }

        self.condition = condition
    }
    
    public func update(text: String?) {
        self.text = text
        self.textRelay.accept(text)
    }
    
    public func update(keyboardType: UIKeyboardType) {
        self.textfield.keyboardType = keyboardType
    }
}

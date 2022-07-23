//
//  DDIPInputView.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/07/22.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift

public final class DDIPInputView: UIView {
    public enum InputType {
        case text
        case custom(action: (() -> ()))
    }
    
    // MARK: - UI Property
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .designSystem(.pretendard, family: .regular, size: ._14)
        return label
    }()
    
    private lazy var inputField: DDIPInputField = {
        let inputField = DDIPInputField(
            placeholder: placeholder,
            condition: condition
        )
        return inputField
    }()
    
    private let helperTextLabel: UILabel = {
        let label = UILabel()
        label.font = .designSystem(.pretendard, family: .regular, size: ._14)
        return label
    }()
    
    private let actionButton = UIButton()
    
    // MARK: - Binding Property
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Property Observers
    
    private var inputType: InputType = .text {
        didSet {
            update(which: .inputType)
        }
    }
    
    private var title: String? {
        didSet {
            update(which: .title)
        }
    }
    
    private var placeholder: String? {
        didSet {
            update(which: .placeholder)
        }
    }
    
    private var _text: String? {
        didSet {
            update(which: .text)
        }
    }
    
    private var helperText: String? {
        didSet {
            update(which: .text)
        }
    }
    
    private var condition: ((String?) -> (Bool))? = nil {
        didSet {
            update(which: .condition)
        }
    }
    
    private var action: (() -> ())? = nil {
        didSet {
            bind()
        }
    }
    
    private var _state: DDIPInputField.State = .normal {
        didSet {
            update(which: .state)
        }
    }
    
    // MARK: - Initializer
    
    public convenience init(inputType: InputType, title: String, placeholder: String) {
        self.init(inputType: inputType, title: title, placeholder: placeholder, condition: nil)
    }
    
    public init(inputType: InputType = .text ,title: String, placeholder: String, condition: ((String?) -> (Bool))? = nil) {
        super.init(frame: .zero)
        layout()
        bind()
        
        update(inputType: inputType)
        update(title: title)
        update(placeholder: placeholder)
        update(condition: condition)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

extension DDIPInputView: AddViewsable {
    private func layout() {
        addSubViews([stackView, actionButton])
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        actionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubviews(titleLabel, inputField, helperTextLabel)
        stackView.setCustomSpacing(8, after: titleLabel)
        stackView.setCustomSpacing(4, after: helperTextLabel)
    }
}

// MARK: - Binding

extension DDIPInputView {
    private func bind() {
        disposeBag = DisposeBag()
        
        bindActionButton()
    }
    
    private func bindActionButton() {
        guard action != nil else { return }
        actionButton.rx.tap
            .debug()
            .subscribe(onNext: { [weak self] in
                self?.action?()
            })
            .disposed(by: disposeBag)
    }
}


// MARK: - Private Update

extension DDIPInputView {
    private enum Update {
        case inputType
        case title
        case placeholder
        case text
        case condition
        case state
    }
    
    private func update(which: Update) {
        switch which {
        case .inputType:
            updateInputType()
        case .title:
            updateTitle()
        case .placeholder:
            updatePlaceholder()
        case .text:
            updateText()
        case .condition:
            updateCondition()
        case .state:
            updateState()
        }
    }
    
    private func updateInputType() {
        switch inputType {
        case .text:
            actionButton.isUserInteractionEnabled = false
            self.action = nil
        case let .custom(action):
            actionButton.isUserInteractionEnabled = true
            self.action = action
        }
    }
    
    private func updateTitle() {
        titleLabel.text = title
    }
    
    private func updatePlaceholder() {
        inputField.update(placeholder: placeholder)
    }
    
    private func updateText() {
        inputField.update(text: _text)
    }
    
    private func updateCondition() {
        inputField.update(condition: condition)
    }
    
    private func updateState() {
        inputField.update(state: _state)
    }
}

// MARK: - Public Update

extension DDIPInputView {
    public func update(title: String?) {
        self.title = title
    }
    
    public func update(placeholder: String?) {
        self.placeholder = placeholder
    }
    
    public func update(text: String?) {
        _text = text
    }
    
    public func update(helperText: String?) {
        self.helperText = helperText
    }
    
    public func update(condition: ((String?) -> Bool)?) {
        guard let condition = condition else { return }

        self.condition = condition
    }
    
    public func update(inputType: InputType) {
        self.inputType = inputType
    }
    
    public func update(state: DDIPInputField.State) {
        self._state = state
    }
}

// MARK: - Public

extension DDIPInputView {
    public func text() -> String? {
        _text
    }
    public func state() -> DDIPInputField.State {
        _state
    }
}

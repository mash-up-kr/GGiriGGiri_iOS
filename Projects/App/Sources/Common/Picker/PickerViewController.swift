//
//  PickerViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/05.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxSwift

final class PickerViewController: BaseViewController<PickerViewModelProtocol> {
    private let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.neutralBlack)?.withAlphaComponent(0.3)
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private var pickerView = UIPickerView()
    
    private lazy var toolBar: KeyboardAccessoryToolbar = {
        let toolBar = KeyboardAccessoryToolbar()
        toolBar.didTapDoneButton
            .subscribe(onNext: { [weak self] in
                self?.dismissPicker()
            })
            .disposed(by: disposeBag)
        return toolBar
    }()
    
    private let disposeBag = DisposeBag()
    
    override func configure() {
        super.configure()
        modalPresentationStyle = .overFullScreen
        view.backgroundColor = .designSystem(.neutralWhite)?.withAlphaComponent(0.2)
        
        pickerView.backgroundColor = .designSystem(.neutralWhite)
        pickerView.delegate = viewModel
        pickerView.dataSource = viewModel
        pickerView.addSubview(toolBar)
    }
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(with: [dimView, stackView])
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        stackView.addArrangedSubviews(with: [
            toolBar,
            pickerView
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissPicker()
    }
    
    private func dismissPicker() {
        viewModel.willDismiss()
        dismiss(animated: false)
    }
}

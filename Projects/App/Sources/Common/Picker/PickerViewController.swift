//
//  PickerViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/05.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class PickerViewController: BaseViewController<PickerViewModelProtocol> {
    private let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.neutralBlack)?.withAlphaComponent(0.3)
        return view
    }()
    private let pickerView = UIPickerView()
    
    override func configure() {
        super.configure()
        modalPresentationStyle = .overFullScreen
        view.backgroundColor = .designSystem(.neutralWhite)?.withAlphaComponent(0.2)
    }
    
    private func pickerViewLayout() {
        pickerView.backgroundColor = .designSystem(.neutralWhite)
        pickerView.delegate = viewModel
        pickerView.dataSource = viewModel
    }
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(with: [dimView, pickerView])
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pickerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        pickerViewLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewModel.willDismiss()
        dismiss(animated: false)
    }
}

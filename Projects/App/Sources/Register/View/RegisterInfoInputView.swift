//
//  RegisterInfoInputView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/15.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class RegisterInfoInputView: BaseView {
    
    private let titleLabel = TempLabel(color: .black, text: "브랜드", font: .systemFont(ofSize: 14))
    private let textInputView = TextInputView()
    
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(titleLabel)
        addSubview(textInputView)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        textInputView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.height.equalTo(54)
        }
    }
    
    override func configure() {
        super.configure()
    }
    
    func configure(with title: String, placeholder: String) {
        titleLabel.text = title
        textInputView.configure(with: placeholder)
    }
}

fileprivate class TextInputView: BaseView {
    
    private let inputField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "브랜드명을 입력해주세요."
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(inputField)
        
        inputField.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(17)
            $0.bottom.equalTo(-17)
        }
    }
    
    override func configure() {
        super.configure()
        
        self.layer.cornerRadius = 12
        backgroundColor = UIColor(red: 251.0 / 256, green: 251.0 / 256, blue: 251.0 / 256, alpha: 1)
    }
    
    func configure(with placeholder: String) {
        inputField.placeholder = "\(placeholder)을 입력해주세요."
    }
}

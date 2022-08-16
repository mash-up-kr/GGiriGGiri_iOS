//
//  KeyboardAccessoryToolbar.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/13.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import RxRelay
import RxSwift

final class KeyboardAccessoryToolbar: UIToolbar {
    private lazy var doneButton: UIButton = {
        let button = UIButton(type : .custom)
        button.titleLabel?.font = .designSystem(.pretendard, family: .medium, size: ._14)
        button.setTitleColor(.designSystem(.secondaryBlue), for: .normal)
        button.setTitle("완료", for: .normal)
        button.frame = CGRect(x: .zero, y: .zero, width: 20, height : 20)
        button.addTarget(self, action: #selector(doneButtonTapAction), for: .touchUpInside)
        return button
    }()
    
    let didTapDoneButton = PublishRelay<Void>()
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        configure()
    }
    
    private func configure() {
        self.barStyle = .default
        self.isTranslucent = true
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButtonItem = UIBarButtonItem(customView: doneButton)
        self.items = [flexSpace, doneButtonItem]
        self.sizeToFit()
    }

    @objc
    private func doneButtonTapAction() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        didTapDoneButton.accept(Void())
    }
}

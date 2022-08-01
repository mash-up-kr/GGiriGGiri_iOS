//
//  DDipListCardApplyBaseView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardApplyBaseView: UIStackView {
    public let drawLabel = UILabel()
    public let alarmButton: DDIPCardListButton?
    
    public init(
        alarmButton: DDIPCardListButton? = nil
    ) {
        self.alarmButton = alarmButton
        super.init(frame: .zero)
        setStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStackView() {
        if let alarmButton = alarmButton  {
            self.addArrangedSubview(alarmButton)
        }
        
        self.addArrangedSubview(drawLabel)
    }
}

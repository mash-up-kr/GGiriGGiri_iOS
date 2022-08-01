//
//  DDipListCardApplyView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardApplyView: DDipListCardApplyBaseView {
    private let style: DDIPListCardViewStyle
    
    private func setDrawLabel() {
        drawLabel.text = "\(style.description) 응모"
        drawLabel.textColor = .designSystem(.neutralGray500)
        drawLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
    }
    
    public init(style: DDIPListCardViewStyle) {
        self.style = style
        super.init(alarmButton: .init(style: .init(buttonColor: .designSystem(.secondarySkyblue200), title: .progress, isHidden: false)))
        setDrawLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

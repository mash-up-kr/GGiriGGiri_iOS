//
//  DDipListCardDeadlineView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardDeadlineView: DDipListCardApplyBaseView {
    private let style: DDIPListCardViewStyle
    
    private func setDrawLabel() {
        drawLabel.text = "\(style.applyStatus.description)까지 \(style.description)시간 남았어요!"
        drawLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
    }
    
    public init(style: DDIPListCardViewStyle) {
        self.style = style
        super.init(alarmButton: .init(style: .init(buttonColor: .designSystem(.secondaryBlue), title: .apply, isHidden: false)))
        setDrawLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  DDipListCardCompleteView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardCompleteView: DDipListCardApplyBaseView {
    private let style: DDIPListCardViewStyle
    
    private func setDrawLabel() {
        drawLabel.text = "\(style.description) 전달 완료"
        drawLabel.font = .designSystem(.pretendard, family: .bold, size: ._14)
        drawLabel.textColor = .designSystem(.secondaryBlue)
    }
    
    public init(style: DDIPListCardViewStyle) {
        self.style = style
        super.init()
        setDrawLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

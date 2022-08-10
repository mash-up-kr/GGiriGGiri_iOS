//
//  DDipListCardCompleteView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardCompleteView: DDipListCardApplyBaseView {
    public override init() {
        super.init()
        setAttribute()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setDrawLabel(drawDate: Date?, registerStatus: String) {
        if let drawDate = drawDate {
            drawLabel.text = "\(drawDate.fullDateString()) \(registerStatus)"
        } else {
            drawLabel.text = "\(registerStatus)"
        }
    }

    public func setAttribute() {
        drawLabel.font = .designSystem(.pretendard, family: .bold, size: ._14)
        drawLabel.textColor = .designSystem(.secondaryBlue)
        drawLabel.textAlignment = .left

        cardListButton.isHidden = true
    }
}

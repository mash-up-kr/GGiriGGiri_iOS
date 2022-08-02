//
//  DDipListCardApplyView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardApplyView: DDipListCardApplyBaseView {
    public func setDrawLabel(applyDate: String) {
        drawLabel.text = "\(applyDate) 응모"
        drawLabel.textColor = .designSystem(.neutralGray500)
        drawLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
        cardListButton.setButtonAttribute(titleStatus: .progress, buttonColor: .designSystem(.secondarySkyblue200), isHidden: false)
    }
}

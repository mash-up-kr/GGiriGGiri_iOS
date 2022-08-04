//
//  DDipListCardApplyView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardApplyView: DDipListCardApplyBaseView {
    public override init() {
        super.init()
        setDrawLabelAttribute()
        setCardListButton()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setDrawLabel(applyDate: Date) {
        drawLabel.text = "\(applyDate.fullDateString()) 응모"
    }

    public func setDrawLabelAttribute() {
        drawLabel.textColor = .designSystem(.neutralGray500)
        drawLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
    }

    public func setCardListButton() {
        cardListButton.setButtonAttribute(titleStatus: .progress, buttonColor: .secondarySkyblue200, isHidden: false, isEnabled: false)
    }
}

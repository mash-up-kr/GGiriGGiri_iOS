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
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setDrawLabel(applyDate: Date) {
        drawLabel.text = "\(applyDate.fullDateString(.dot)) 응모"
    }

    public func setDrawLabelAttribute() {
        drawLabel.textColor = .designSystem(.neutralGray500)
        drawLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
        drawLabel.textAlignment = .right
    }

    public func setCardListButton(_ status: DDIPCardListButton.AppliedStatus) {
        switch status {
        case .confirmResult:
            cardListButton.setButtonAttribute(
                title: status.title,
                buttonColor: .secondaryBlue,
                isHidden: false,
                isEnabled: true
            )
        case .inprogress, .win, .lose:
            cardListButton.setButtonAttribute(
                title: status.title,
                buttonColor: .secondarySkyblue200,
                isHidden: false,
                isEnabled: false
            )
        }
    }
}

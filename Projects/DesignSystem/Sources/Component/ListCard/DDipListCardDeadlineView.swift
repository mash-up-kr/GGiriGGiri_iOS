//
//  DDipListCardDeadlineView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardDeadlineView: DDipListCardApplyBaseView {
    public override init() {
        super.init()
        setAttribute()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setListCardButton(buttonTitle: DDIPCardListButton.TitleStatus, buttonColor: UIColor?, isHidden: Bool) {
        cardListButton.setButtonAttribute(titleStatus: buttonTitle, buttonColor: buttonColor, isHidden: isHidden)
    }

    public func setDrawLabel(titleStatus: String, leftTime: String) {
        drawLabel.text = "\(titleStatus)까지 \(leftTime)시간 남았어요!"
    }

    public func setAttribute() {
        drawLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
    }
}

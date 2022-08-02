//
//  DDipListCardCompleteView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/30.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDipListCardCompleteView: DDipListCardApplyBaseView {
    public func setDrawLabel(drawDate: String) {
        drawLabel.text = "\(drawDate) 전달 완료"
        drawLabel.font = .designSystem(.pretendard, family: .bold, size: ._14)
        drawLabel.textColor = .designSystem(.secondaryBlue)

        cardListButton.isHidden = true
    }
}

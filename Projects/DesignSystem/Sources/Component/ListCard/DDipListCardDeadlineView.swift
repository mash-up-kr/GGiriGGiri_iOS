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
    
    public func setListCardButton(buttonTitle: DDIPCardListButton.TitleStatus, buttonColor: DDIPColor, isHidden: Bool) {
        cardListButton.setButtonAttribute(titleStatus: buttonTitle, buttonColor: buttonColor, isHidden: isHidden)
    }

    public func setDrawLabel(titleStatus: String, leftTime: Date) {
        let fullText = "\(titleStatus)까지 \(leftTime.hourString())시간 남았어요!"
        let leftTimeText = "\(leftTime.hourString())시간"
        let resultTitle = "\(titleStatus)"
        let attributedString = NSMutableAttributedString(string: fullText)

        attributedString.setAttributes(
            [
                .font: UIFont.designSystem(.pretendard, family: .regular, size: ._14)
            ],
            range: NSString(string: fullText).range(of: fullText)
        )

        attributedString.setAttributes(
            [
                .foregroundColor: UIColor.designSystem(.secondaryBlue),
                .font: UIFont.designSystem(.pretendard, family: .bold, size: ._14)
            ],
            range: NSString(string: fullText).range(of: leftTimeText)
        )

        attributedString.setAttributes(
            [
            .font: UIFont.designSystem(.pretendard, family: .bold, size: ._14)
            ],
            range: NSString(string: fullText).range(of: resultTitle))

        drawLabel.attributedText = attributedString
    }

    public func setAttribute() {
        drawLabel.font = .designSystem(.pretendard, family: .regular, size: ._14)
    }
}

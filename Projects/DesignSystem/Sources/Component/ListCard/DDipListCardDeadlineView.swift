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
    
    public func setCardListButton(_ status: DDIPCardListButton.ApplyStatus) {
        switch status {
        case .enable:
            cardListButton.setButtonAttribute(
                title: status.title,
                buttonColor: .secondaryBlue,
                isHidden: false,
                isEnabled: true
            )
        case .complete:
            cardListButton.setButtonAttribute(
                title: status.title,
                buttonColor: .secondarySkyblue200,
                isHidden: false,
                isEnabled: false
            )
        }
    }
    
    public func setDrawLabel(title: String, leftTime: Date) {
        let fullText = "\(title)까지 \(leftTime.hourString())시간 남았어요!"
        let leftTimeText = "\(leftTime.hourString())시간"
        let resultTitle = "\(title)"
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
        drawLabel.textAlignment = .center
    }
}

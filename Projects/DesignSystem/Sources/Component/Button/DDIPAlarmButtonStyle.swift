//
//  DDIPAlarmButtonStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPAlarmButtonStyle {
    public enum TitleStatus: String {
        case checkResult = "결과 확인"
        case confirmed = "확인 완료"
    }
    
    public let buttonColor: UIColor
    public let title: TitleStatus?
    public let topInset: CGFloat
    public let leftInset: CGFloat
    public let rightInset: CGFloat
    public let bottomInset: CGFloat
    
    public init(
        buttonColor: UIColor,
        title: TitleStatus?,
        topInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat,
        bottomInset: CGFloat
    ) {
        self.buttonColor = buttonColor
        self.title = title
        self.topInset = topInset
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.bottomInset = bottomInset
    }
}

//
//  DDIPButtonStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public struct DDIPButtonStyle {
    
    public enum ButtonHeight: CGFloat {
        case height_34 = 34
        case height_36 = 36
    }
    
    public let buttonColor: UIColor
    public let titleColor: UIColor?
    public let buttonFont: UIFont
    public let title: String?
    public let radius: CGFloat
    public let height: ButtonHeight
    public let topInset: CGFloat
    public let leftInset: CGFloat
    public let rightInset: CGFloat
    public let bottomInset: CGFloat
    
    public init(
        buttonColor: UIColor,
        titleColor: UIColor?,
        buttonFont: UIFont,
        title: String?,
        radius: CGFloat,
        height: ButtonHeight,
        topInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat,
        bottomInset: CGFloat
    ) {
        self.buttonColor = buttonColor
        self.titleColor = titleColor
        self.buttonFont = buttonFont
        self.title = title
        self.radius = radius
        self.height = height
        self.topInset = topInset
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.bottomInset = bottomInset
    }
}

//
//  DDIPCategoryButtonStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public struct DDIPCategoryButtonStyle {
    public enum ButtonHeight: CGFloat {
        case height_34 = 34
        case height_36 = 36
    }
    
    public let buttonColor: UIColor
    public let title: String?
    public let height: ButtonHeight
    public let topInset: CGFloat
    public let leftInset: CGFloat
    public let rightInset: CGFloat
    public let bottomInset: CGFloat
    
    public init(
        buttonColor: UIColor,
        title: String?,
        height: ButtonHeight,
        topInset: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat,
        bottomInset: CGFloat
    ) {
        self.buttonColor = buttonColor
        self.title = title
        self.height = height
        self.topInset = topInset
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.bottomInset = bottomInset
    }
}

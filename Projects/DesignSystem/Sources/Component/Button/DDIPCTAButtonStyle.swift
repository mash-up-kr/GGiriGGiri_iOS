//
//  DDIPCTAButtonStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCTAButtonStyle {
    public let buttonColor: UIColor
    public let titleColor: UIColor?
    public let title: String?
    
    public init(
        buttonColor: UIColor,
        titleColor: UIColor,
        title: String
    ) {
        self.buttonColor = buttonColor
        self.titleColor = titleColor
        self.title = title
    }
}

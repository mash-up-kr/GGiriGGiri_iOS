//
//  DDIPCTAButtonStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/07.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCTAButtonStyle {
    /// 프리셋을 만들어보자
    ///
    
    
    public let buttonColor: UIColor
    public let title: String?
    
    public init(
        buttonColor: UIColor,
        title: String
    ) {
        self.buttonColor = buttonColor
        self.title = title
    }
}

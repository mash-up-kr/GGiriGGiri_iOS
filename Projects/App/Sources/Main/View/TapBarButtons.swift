//
//  TapBarButtons.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem

final class TapBarButtons {
    private(set) var mybox: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.designSystem(.iconMyBox24), for: .normal)
        button.frame = CGRect(origin: .zero, size: CGSize(width: 28, height: 28))
        return button
    }()
    
    private(set) var notification: UIButton = {
        let button = UIButton()
        button.setTitle("알림", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.sizeToFit()
        return button
    }()
}

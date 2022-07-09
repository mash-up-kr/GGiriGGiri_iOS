//
//  DDIPCategoryTapViewStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/08.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public struct DDIPCategoryTapViewStyle {
    public enum TapCategoryOptions {
        case box, alarm
        
        var info: (leftTitle: String, rightTitle: String) {
            switch self {
            case .box:
                return ("응모 BOX", "등록 BOX")
            case .alarm:
                return ("결과 알림", "활동 알림")
            }
        }
    }
    
    private let leftOption: TapCategoryOptions
    private let rightOption: TapCategoryOptions
    
    public var leftTitle: String {
        return leftOption.info.leftTitle
    }
    
    public var rightTitle: String {
        return rightOption.info.rightTitle
    }
    
    public init(
        leftOption: TapCategoryOptions,
        rightOption: TapCategoryOptions
    ) {
        self.leftOption = leftOption
        self.rightOption = rightOption
    }
}

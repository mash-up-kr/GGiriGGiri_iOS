//
//  DDIPToastViewStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public struct DDIPToastViewStyle {
    public enum ToastViewOptions {
        case save, register, apply
        
        var info: (title: String, description: String) {
            switch self {
            case .save:
                return ("저장완료", "기프티콘이 갤러리에 저장되었어요.")
            case .register:
                return ("등록 완료", "뿌리기 등록이 완료되었어요!\n 설정한 마감 시간이 지나면 자동적으로 기프티콘이 전달됩니다.")
            case .apply:
                return ("응모 완료", "응모가 완료되었어요!\n 응모 결과는 마감 후에 확인할 수 있어요.")
            }
        }
    }
    
    public let titleOption: ToastViewOptions
    public let descriptionOption: ToastViewOptions
    public let imageIcon: String
    
    public init(
        titleOption: ToastViewOptions,
        descriptionOption: ToastViewOptions,
        imageIcon: String
    ) {
        self.titleOption = titleOption
        self.descriptionOption = descriptionOption
        self.imageIcon = imageIcon
    }
}

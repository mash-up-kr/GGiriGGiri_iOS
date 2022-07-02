//
//  DDIPToastViewStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public struct DDIPToastViewStyle {
    public enum Title: String {
        case save = "저장 완료"
        case register = "등록 완료"
        case apply = "응모 완료"
    }
    
    public enum Description: String {
        case save = "기프티콘이 갤러리에 저장되었어요."
        case register = "뿌리기 등록이 완료되었어요! 설정한 마감 시간이 지나면 자동적으로 기프티콘이 전달됩니다."
        case apply = "응모가 완료되었어요! 응모 결과는 마감 후에 확인할 수 있어요."
    }
    
    public let title: Title
    public let description: Description
    public let imageIcon: String
    
    public init(
        title: Title,
        description: Description,
        imageIcon: String
    ) {
        self.title = title
        self.description = description
        self.imageIcon = imageIcon
    }
}

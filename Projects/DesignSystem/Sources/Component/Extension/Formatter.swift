//
//  Formatter.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/24.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct Formatter {
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        
        return dateFormatter
    }()
    
    private init() {}
}

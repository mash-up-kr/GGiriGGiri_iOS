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
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        
        return dateFormatter
    }()
    
    private init() {}
}

extension DateFormatter {
    func currentDate() -> Date {
        guard let currentDate = Formatter.date.date(from: Date().description) else {
            return Date()
        }
        
        return currentDate
    }
}

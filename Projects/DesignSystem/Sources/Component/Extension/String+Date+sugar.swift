//
//  Date+sugar.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/24.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

extension Date {
    func hourString() -> String {
        Formatter.date.dateFormat = "HH"
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }

    func fullDateString() -> String {
        Formatter.date.dateFormat = "yyyy.MM.dd"
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
}

extension String {
    enum FormatType: String {
        case yearMonthDay = "YYYYMMDD"
        case hourMinuteSecond = "HH:mm:SS"

        var displayName: String {
            return self.rawValue
        }
    }

    func format(_ type: FormatType) -> String {
        let dateData = fullStringDate()

        Formatter.date.dateFormat = type.displayName
        let dateString = Formatter.date.string(from: dateData)

        return dateString
    }

    func fullStringDate() -> Date {
        Formatter.date.dateFormat = "YYYY-MM-DD HH:mm:SS"
        guard let dateData = Formatter.date.date(from: self) else {
            return Date()
        }
        return dateData
    }
}

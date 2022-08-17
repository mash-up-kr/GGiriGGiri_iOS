//
//  Date+sugar.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/24.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

extension Date {
    public enum FormatType: String {
        case dot = "YYYY.MM.dd"
        case plain = "YYYYMMdd"

        var displayName: String {
            return self.rawValue
        }
    }

    func hourString() -> String {
        Formatter.date.dateFormat = "HH"
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }

    func fullDateString(_ type: FormatType) -> String {
        Formatter.date.dateFormat = type.displayName
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
}

extension String {
    public enum FormatType: String {
        case yearMonthDay = "YYYYMMDD"
        case dashYearMonthDay = "YYYY-MM-dd"
        case dotYearMonthDay = "YYYY.MM.dd"
        case hourMinuteSecond = "HH:mm:SS"

        var displayName: String {
            return self.rawValue
        }
    }

    public func format(_ type: FormatType) -> String {
        let dateData = fullStringDate(type)

        Formatter.date.dateFormat = type.displayName
        let dateString = Formatter.date.string(from: dateData)

        return dateString
    }

    public func fullStringDate(_ type: FormatType = .yearMonthDay) -> Date {
        var formatString: String {
            switch type {
            case .yearMonthDay, .dashYearMonthDay, .hourMinuteSecond:
                return "yyyy-MM-dd'T'HH:mm"
            case .dotYearMonthDay:
                return "yyyy.MM.dd'T'HH:mm"
            }
        }
        
        Formatter.date.dateFormat = formatString

        guard let dateData = Formatter.date.date(from: self) else {
            return Date()
        }
        return dateData
    }
}

//
//  Date+sugar.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/24.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

extension Date {
    func ListCardDeadlineString() -> String {
        Formatter.date.dateFormat = "HH"
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }

    func listCardString() -> String {
        Formatter.date.dateFormat = "yyyy.MM.dd"
        guard let dateString = Formatter.date.string(for: self) else { return "" }
        return dateString
    }
}

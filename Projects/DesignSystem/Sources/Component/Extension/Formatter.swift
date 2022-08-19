//
//  Formatter.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/24.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct Formatter {
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = .current
        return dateFormatter
    }()
    
    private init() {}
}

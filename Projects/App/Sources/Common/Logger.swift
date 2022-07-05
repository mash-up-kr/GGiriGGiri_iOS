//
//  Logger.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/06.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation
import OSLog

struct Log {
    static func info(_ message: String) {
        os_log(.info, log: .default, "%@", message)
    }
}

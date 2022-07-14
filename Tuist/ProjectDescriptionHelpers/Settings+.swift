//
//  Settings+.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2022/07/13.
//

import ProjectDescription

extension Settings {
    static let application: Settings = .settings(
        base: [
            "EXCLUEDED_ARCHS": "arm64, 86_64"
        ],
        configurations: [
            .debug(
                name: "Debug",
                xcconfig: "../Configurations/Application.xcconfig"
            ),
            .release(
                name: "Release",
                xcconfig: "../Configurations/Application.xcconfig"
            )
        ],
        defaultSettings: .none)
}

//
//  Settings+.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2022/07/13.
//

import ProjectDescription

extension Settings {
    static let appProject: Settings = .settings(
        base: [
            "EXCLUEDED_ARCHS": "arm64"
        ],
        configurations: [
            .debug(
                name: "Debug",
                xcconfig: "../Configurations/Project-Debug.xcconfig"
            ),
            .release(
                name: "Release",
                xcconfig: "../Configurations/Project-Release.xcconfig"
            )
        ],
        defaultSettings: .none)
    
    static let appTarget: Settings = .settings(
        base: [:],
        configurations: [
            .debug(
                name: "Debug",
                xcconfig: "../Configurations/GGiriGGiri-Debug.xcconfig"
            ),
            .release(
                name: "Release",
                xcconfig: "../Configurations/GGiriGGiri-Release.xcconfig"
            )
        ],
        defaultSettings: .none
    )
}

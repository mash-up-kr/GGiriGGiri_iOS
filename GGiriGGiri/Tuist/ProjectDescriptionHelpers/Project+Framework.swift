//
//  Project+Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2022/06/19.
//

import ProjectDescription

extension Project {
    public static func framework(name: String, targets: [Target]) -> Project {
        Project(name: name,
                organizationName: "dvHuni",
                options: .options(
                    disableBundleAccessors: true,
                    disableSynthesizedResourceAccessors: true
                ),
                targets: targets)
    }
}

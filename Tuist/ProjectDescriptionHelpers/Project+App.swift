//
//  Project+App.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2022/06/19.
//

import ProjectDescription

extension Project {
    public static func app(name: String, targets: [Target]) -> Project {
        Project(name: name,
                organizationName: "dvHuni",
                options: .options(
                    disableBundleAccessors: true,
                    disableSynthesizedResourceAccessors: true
                ),
                settings: .application,
                targets: targets)
    }
}

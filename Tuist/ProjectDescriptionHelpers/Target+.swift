//
//  Target+.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2022/06/19.
//

import ProjectDescription

extension Target {
    public static func appTarget(name: String) -> Target {
        Target(name: name,
               platform: .iOS,
               product: .app,
               bundleId: "com.sz.mashup.\(name)",
               deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
               infoPlist: .file(path: "SupportingFiles/\(name)-Info.plist"),
               sources: [
                "Sources/**"
               ],
               resources: [
                "Resources/**"
               ],
               dependencies: [
                .project(target: "DesignSystem", path: "../DesignSystem"),
                .external(name: "Alamofire"),
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "Kingfisher"),
                .external(name: "PinLayout"),
                .external(name: "FlexLayout"),
                .external(name: "Lottie"),
                .external(name: "SnapKit")
               ])
    }
    
    public static func frameworkTarget(name: String) -> Target {
        Target(
            name: name,
            platform: .iOS,
            product: .framework,
            bundleId: "com.sz.mashup.GGiriGGiri.DesignSystem",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
            infoPlist: .file(path: "SupportingFiles/\(name)-Info.plist"),
            sources: [
                "Sources/**"
            ],
            resources: [
                "Resources/**"
            ],
            dependencies: [
                .external(name: "RxSwift"),
                .external(name: "RxCocoa")
            ]
        )
    }
}

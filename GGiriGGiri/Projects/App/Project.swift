//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2022/06/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "App",
                      organizationName: "dvHuni",
                      options: .options(
                        disableBundleAccessors: true,
                        disableSynthesizedResourceAccessors: true
                      ),
                      targets: [
                        Target(name: "GGiriGGiri",
                               platform: .iOS,
                               product: .app,
                               bundleId: "com.sz.mashup.GGiriGGiri",
                               deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
                               infoPlist: .file(path: "SupportingFiles/GGiriGGiri-Info.plist"),
                               sources: [
                                "Sources/**"
                               ],
                               resources: ["Resources/**"])
                      ])

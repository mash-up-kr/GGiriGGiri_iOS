//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2022/06/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let proejct = Project.framework(name: "DesignSysytem",
                                targets: [
                                    Target(
                                        name: "DesignSystem",
                                        platform: .iOS,
                                        product: .framework,
                                        bundleId: "com.sz.mashup.GGiriGGiri.DesignSystem",
                                        infoPlist: .file(path: "SupportingFiles/DesignSystem-Info.plist"),
                                        sources: [
                                            "Sources/**"
                                        ],
                                        resources: [
                                            "Resources/**"
                                        ])
                                ])

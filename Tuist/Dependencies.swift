//
//  Dependencies.swift
//  Config
//
//  Created by AhnSangHoon on 2022/06/22.
//

import ProjectDescription

let dependencies = Dependencies(swiftPackageManager: SwiftPackageManagerDependencies.dependencies,
                                platforms: [.iOS])




extension SwiftPackageManagerDependencies {
    public static var dependencies: SwiftPackageManagerDependencies {
        .init([
            .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .exact("5.6.1")),
            .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .exact("6.5.0")),
            .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .exact("7.0.0")),
            .remote(url: "https://github.com/layoutBox/PinLayout", requirement: .upToNextMajor(from: "1.10.3")),
            .remote(url: "https://github.com/layoutBox/FlexLayout.git", requirement: .exact("1.3.18")),
            .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .exact("3.2.1")),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
            .remote(url: "https://github.com/kirualex/SwiftyGif", requirement: .upToNextMajor(from: "5.4.3"))
        ])
    }
}

//
//  AppDelegate.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import UIKit

import DesignSystem

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialize()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Initialize
extension AppDelegate {
    private func initialize() {
        DDIPFont.registerFonts()
    }
}

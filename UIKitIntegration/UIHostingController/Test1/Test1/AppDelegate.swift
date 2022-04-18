//
//  AppDelegate.swift
//  Test1
//
//  Created by jrasmusson on 2022-04-18.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

        let navigationController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigationController

        return true
    }

}

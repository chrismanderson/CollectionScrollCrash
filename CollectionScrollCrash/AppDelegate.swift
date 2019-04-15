//
//  AppDelegate.swift
//  CollectionScrollCrash
//
//  Created by Chris Anderson on 4/15/19.
//  Copyright © 2019 Polutropos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()

        UICollectionView.appearance().backgroundColor = .white

        return true
    }
}

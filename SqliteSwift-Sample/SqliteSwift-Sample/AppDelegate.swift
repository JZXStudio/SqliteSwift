//
//  AppDelegate.swift
//  SqliteSwift
//
//  Created by SONG JIN on 2025/4/23.
//

import UIKit

import ATools

@main
class AppDelegate: AAppDelegate {
    override func a_DidFinishLaunchingWithOptions(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        super.a_DidFinishLaunchingWithOptions(application, didFinishLaunchingWithOptions: launchOptions)
        
        let rootView: StoreVC = StoreVC()
        let navigationController: UINavigationController = UINavigationController(rootViewController: rootView)
        
        a_window?.rootViewController = navigationController
        a_window?.whiteBackgroundColor()
        a_window?.makeKeyAndVisible()
    }
}


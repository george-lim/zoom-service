//
//  AppDelegate.swift
//  ZoomSDK
//
//  Created by George Lim on 2017-07-24.
//  Copyright © 2017 George Lim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Authenticate usage of Zoom MobileRTC SDK.
    ZoomService.sharedInstance.authenticateSDK()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.rootViewController = ViewController()
    window!.makeKeyAndVisible()
    return true
  }
}

//
//  AppDelegate.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    NSNotificationCenter.defaultCenter().postNotificationName("applicationWillResignActive", object: self)
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    NSNotificationCenter.defaultCenter().postNotificationName("applicationDidEnterBackground", object: self)
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    NSNotificationCenter.defaultCenter().postNotificationName("applicationWillEnterForeground", object: self)
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    NSNotificationCenter.defaultCenter().postNotificationName("applicationDidBecomeActive", object: self)
  }


}


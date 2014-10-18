//
//  AppDelegate.swift
//  Slang
//
//  Created by Tosin Afolabi on 18/10/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var homeViewController: RootViewController = {
        let homeViewController = RootViewController()
        return homeViewController
    }()

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.blackColor()
        win.rootViewController = self.homeViewController
        return win
    }()

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
        window.makeKeyAndVisible()
        return true
    }
}


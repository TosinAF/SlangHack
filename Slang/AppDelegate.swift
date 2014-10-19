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

    /*lazy var homeViewController: SLLogin = {
        let homeViewController = SLLogin()
        return homeViewController
    }()*/

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.blackColor()
        win.rootViewController = UINavigationController(rootViewController: self.homeViewController)
        return win
    }()

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
        window.makeKeyAndVisible()

        let SANDBOX_HOST = ENSessionHostSandbox
        let CONSUMER_KEY = "ipalibo-4693"
        let CONSUMER_SECRET = "e4f9b59ad8a87f28"

        [ENSession .setSharedSessionConsumerKey(CONSUMER_KEY, consumerSecret: CONSUMER_SECRET, optionalHost: SANDBOX_HOST)]
        return true
    }
}


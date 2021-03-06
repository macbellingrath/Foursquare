//
//  AppDelegate.swift
//  Venues
//
//  Created by Mac Bellingrath on 10/6/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SFSafariViewControllerDelegate {

    var window: UIWindow?
    var safariVC: SFSafariViewController!

    
    func attemptLogin() {
        print(window?.rootViewController)
        let url = NSURL(string: "https://foursquare.com/oauth2/authenticate?client_id=" + CLIENT_ID + "&response_type=code&redirect_uri=http://macbellingrath.com")
        
        if let login = url {
            
            print(login)
            
            safariVC = SFSafariViewController(URL: login)
            
            safariVC!.delegate = self
            
            self.window?.rootViewController?.presentViewController(self.safariVC, animated: true, completion: nil)
            
        }
    }



    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        attemptLogin()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
      
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        print(url.scheme)
        print(url)
        
        url.query!.componentsSeparatedByString("&")
        // just making sure we send the notification when the URL is opened in SFSafariViewController
        if (sourceApplication == "com.apple.SafariViewService") {
            NSNotificationCenter.defaultCenter().postNotificationName(kSafariViewControllerCloseNotification, object: url)
            return true
        }
        return true
    }
   

}


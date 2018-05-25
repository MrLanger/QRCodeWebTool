//
//  AppDelegate.swift
//  QRCodeWebTool
//
//  Created by baisen on 2017/5/17.
//  Copyright © 2017年 besonit. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// 设置友盟
        UMessage.start(withAppkey: "593e536d45297d283a00063a", launchOptions: launchOptions, httpsEnable: true)
        UMessage.openDebugMode(true)
        let board = UIStoryboard(name: "Main", bundle: nil)
        UMessage.addLaunch(with: window!, finish: board.instantiateInitialViewController()!)
        /// 注册
        UMessage.registerForRemoteNotifications()
        /// ios 10
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self;
            let types10: UNAuthorizationOptions = [UNAuthorizationOptions.badge, UNAuthorizationOptions.alert, UNAuthorizationOptions.sound]
            center.requestAuthorization(options: types10, completionHandler: { (granted, error) in
                if (granted) {
                    //点击允许
                    
                } else {
                    //点击不允许
                    
                }
            })
            
        } else {
            // Fallback on earlier versions
        }
        
        UMessage.setLogEnabled(true)
        
        setIQKeyboard()
        
        return true
    }
    
    
    func setIQKeyboard() {
        let kebordMenager = IQKeyboardManager.sharedManager()
        //控制整个功能是否启用
        IQKeyboardManager.sharedManager().enable = true
        kebordMenager.keyboardDistanceFromTextField = 40;
        //控制点击背景是否收起键盘
        kebordMenager.shouldResignOnTouchOutside = true;
        //控制键盘上的工具条文字颜色是否用户自定义
        kebordMenager.enableAutoToolbar = false;
        kebordMenager.shouldShowTextFieldPlaceholder = true;
    }

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        UMessage.setAutoAlert(false)
        UMessage.didReceiveRemoteNotification(userInfo)
        
        let ud = UserDefaults.standard
        let str: NSString = NSString.init(format: "%@", userInfo)
        ud.set(str, forKey: "UMPuserInfoNotification")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userInfoNotification"), object: self, userInfo: ["userinfo":str])
    }
    
    /// iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo;
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            
            let aps: [String : Any] = userInfo["aps"] as! [String : Any]
            let alert: [String : Any] = aps["alert"] as! [String : Any]
            let body = alert["body"]
            
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
//            let str: NSString = NSString.init(format: "%@", userInfo)
            let ud = UserDefaults.standard
            ud.set(body, forKey: "UMPuserInfoNotification")
        }
    }
    
    /// iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo;
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            let aps: [String : Any] = userInfo["aps"] as! [String : Any]
            let alert: [String : Any] = aps["alert"] as! [String : Any]
            let body = alert["body"]
            
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
//            let str: NSString = NSString.init(format: "%@", userInfo)
            let ud = UserDefaults.standard
            ud.set(body, forKey: "UMPuserInfoNotification")
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
        
        
        let str = stringDevicetoken(deviceToken: deviceToken as NSData)
        print("-----\(str)")
    }
    
    func stringDevicetoken(deviceToken: NSData) -> String {
        let token = deviceToken.description as NSString
        let pushtoken = token.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        
        return pushtoken
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


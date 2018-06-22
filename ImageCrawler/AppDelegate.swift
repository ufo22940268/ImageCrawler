//
//  AppDelegate.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/7.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import UIKit
import Switch
import NetworkExtension
import NEKit
import CocoaLumberjackSwift
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var server:GCDHTTPProxyServer?
    var socks5Proxy:GCDSOCKS5ProxyServer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DDLog.removeAllLoggers()
        DDLog.add(DDTTYLogger.sharedInstance, with: .info)
//        
        ObserverFactory.currentFactory = ServerObserverFactory()
        
        server = GCDHTTPProxyServer(address: nil, port: NEKit.Port(port: UInt16(9090)))
        // swiftlint:disable force_try
        
        try! server!.start()
        
//        tryRealm()
        
        NetworkManager().start()

        return true
    }
    

//    func tryRealm() {
//        let requestRecord = RequestRecord()
//        requestRecord.tunnelId = "123"
//        let realm = try! Realm()
//
//        try! realm.write {
//            realm.add(requestRecord)
//        }
//        let requests = realm.objects(RequestRecord.self)
//        print(requests.count)
//    }

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
    
    func applicationDidFinishLaunching(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        server?.stop()
        socks5Proxy?.stop()
    }

}


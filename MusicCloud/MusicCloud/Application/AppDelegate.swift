//
//  AppDelegate.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let bundleID = (Bundle.main.bundleIdentifier ?? "") as String
        print("====> BundleID= \(bundleID)")
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIStackView.self, UIView.self]
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //Feed
        let streamVC = StreamVC()
        let streamNavi = UINavigationController(rootViewController: streamVC)
        streamNavi.tabBarItem = UITabBarItem(title: "Stream", image: UIImage(named: "cloud"), tag: 0)
        
        //Search
        let searchVC = SearchVC()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchNavi.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 2)
        
        //NewPost
        let playlistVC = PlaylistVC()
        let playlistNavi = UINavigationController(rootViewController: playlistVC)
        playlistNavi.tabBarItem = UITabBarItem(title: "Playlists", image: UIImage(systemName: "infinity"), tag: 1)
        
        //Like
        let historyVC = HistoryVC()
        let historyNavi = UINavigationController(rootViewController: historyVC)
        historyNavi.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history"), tag: 3)
        
        //Profile
        let profileVC = ProfileVC()
        let profileNavi = UINavigationController(rootViewController: profileVC)
        profileNavi.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "gender-neutral"), tag: 4)
        
        //tabbar controller
        let tabbarController = UITabBarController()
        tabbarController.delegate = self
        tabbarController.viewControllers = [streamNavi, playlistNavi, searchNavi, historyNavi, profileNavi]
        tabbarController.tabBar.tintColor = UIColor(red: 0.100, green: 0.771, blue: 0.530, alpha: 1.000)
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
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

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected Tab : \(tabBarController.selectedIndex)")
    }
}

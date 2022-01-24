//
//  AppDelegate.swift
//  WalletWalk
//
//  Created by Sarika scc on 18/01/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,.font:UIFont(name: Font_Roboto.bold, size: 24)!]
        appearance.backgroundColor = appTxtColor!
        
        let button = UIBarButtonItemAppearance()
        button.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.buttonAppearance = button
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let appearance1 = UITabBarAppearance()
        appearance1.configureWithOpaqueBackground()
        appearance1.backgroundColor = appTxtColor!
        
        appearance1.stackedLayoutAppearance.normal.iconColor = .white
        appearance1.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.white]
        UITabBar.appearance().standardAppearance = appearance1
        
        if defaults.value(forKey: VHkey.login) != nil {
            
            setVCRoot(vcName: "MainTab", type: .tab)
        }
        else
        {
            setVCRoot(vcName: "LoginNavi", type: .navi)
        }
        
        
        return true
    }

    
}


//
//  AppDelegate.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 29/11/2022.
//

import FirebaseCore
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        RunLoop.current.run(until: NSDate(timeIntervalSinceNow: 5) as Date)
        
        let userDefaults = UserDefaults.standard
        
        if let language = userDefaults.string(forKey: "Language") {
            UserDefaults.standard.set(language, forKey: "Language")
            Bundle.setLanguage(language)
            
            if let THEME_KEY = UserDefaults.standard.object(forKey: R.string.localizable.themeKey()) as? String {
                if THEME_KEY == R.string.localizable.lightTheme() {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                } else if THEME_KEY == R.string.localizable.darkTheme() {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                }
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application (_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

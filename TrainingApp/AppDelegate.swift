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

        if UserDefaults.standard.object(forKey: R.string.localizable.themeKey()) as! String == R.string.localizable.lightTheme() {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        }
        else if UserDefaults.standard.object(forKey: R.string.localizable.themeKey()) as! String == R.string.localizable.darkTheme() {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        }
        
        if UserDefaults.standard.object(forKey: R.string.localizable.language()) != nil && UserDefaults.standard.object(forKey: R.string.localizable.language()) as! String == "pl" {
            UserDefaults.standard.set("pl",forKey: R.string.localizable.language())
//            Bundle.setLanguage((targetLang != nil) ? targetLang! : "en")
        }
//        else if UserDefaults.standard.object(forKey: "Language") != nil && UserDefaults.standard.object(forKey: "Language") as! String == "en" {
//            UserDefaults.standard.set("en", forKey: "Language")
//            Bundle.setLanguage((targetLang != nil) ? targetLang! : "en")
//        }
        else {
            UserDefaults.standard.set("en", forKey: "Language")
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

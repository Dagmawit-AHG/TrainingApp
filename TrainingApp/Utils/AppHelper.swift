//
//  AppHelper.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 24/01/2023.
//

import CoreData

class AppHelper: NSManagedObject {
    
    public static func localized(_ key: String, language: String? = nil) -> String {
            let language = language ?? Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "en"
            guard let path = Bundle.main.path(forResource: language, ofType: "lproj"), let bundle = Bundle(path: path) else {
                return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
            }
            return bundle.localizedString(forKey: key, value: nil, table: nil)
        }
}

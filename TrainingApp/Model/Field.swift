//
//  Field.swift
//  TrainingApp
//
//  Created by Dagmawit Alemayehu on 03/01/2023.
//

import Foundation

struct Field: Codable {
    var id: String
    var type: String
    var code: String
    var name: String
    var country_code: String
    var country_name: String
    var city_code: String?
    var city_name: String?
    var state_code: String?
    var coordinates: [String:Float]
    var index_strings: [String]?
    var weight: Int
    var cases: String?
    var city_cases: String?
    var country_cases: String?
//    let main_airport_name: String?
}

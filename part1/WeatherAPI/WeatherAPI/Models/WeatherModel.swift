//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Chakane Shegog on 12/23/21.
//

import Foundation

struct place: Codable {
    let location: locationID
    let current: currentStats
}

struct locationID: Codable {
    let name: String
    let country: String
}

struct currentStats: Codable {
    let temp_f: Double
    let feelslike_f: Double
    let wind_mph: Double
    let wind_dir: String
    let humidity: Int
    let condition: sky
}

struct sky: Codable {
    let text: String
}

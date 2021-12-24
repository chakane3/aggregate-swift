//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Chakane Shegog on 12/23/21.
//

import Foundation

struct place: Codable {
    let location: [placeLocation]
}

struct placeLocation: Codable {
    let country: String
    let current: [currentConditions]
}

struct currentConditions: Codable {
    let condition: [conditionDict]
}

struct conditionDict: Codable {
    let text: String
}

extension place {
    static func getWeather(from jsonData: Data) throws -> place {
        do {
            let weatherFromPlace = try JSONDecoder().decode(place.self, from: jsonData)
            return weatherFromPlace
        } catch {
            throw error
        }
    }
}


//chakanezshegogggggggg

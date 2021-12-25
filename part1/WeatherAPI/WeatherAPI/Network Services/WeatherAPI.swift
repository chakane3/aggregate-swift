//
//  WeatherAPI.swift
//  WeatherAPI
//
//  Created by Chakane Shegog on 12/23/21.
//

import Foundation

struct WeatherAPI {
    
    // this function takes in a search query from a user and return us a weather object
    // It uses a completion handler to handle the network request as we compile our data
    static func fetchRecipe(for searchQuery: String, completion: @escaping (Result<place, AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "or not"
        let weatherEndpoint = "https://api.weatherapi.com/v1/forecast.json?key=\(SecretKey.privateKey)&q=\(searchQuery)&days=1"
        
        // check if our url is bad
        guard let url = URL(string: weatherEndpoint) else {
            completion(.failure(.badURL(weatherEndpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(place.self, from: data)
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

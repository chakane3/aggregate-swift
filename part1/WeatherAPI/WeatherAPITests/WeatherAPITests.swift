//
//  WeatherAPITests.swift
//  WeatherAPITests
//
//  Created by Chakane Shegog on 12/23/21.
//

import XCTest
@testable import WeatherAPI

class WeatherAPITests: XCTestCase {
    
    func testNetowkrConnection() {
        // arrange
        let searchQuery = "New York".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let exp = XCTestExpectation(description: "data found")
        let endpoint = "https://api.weatherapi.com/v1/forecast.json?key=\(SecretKey.privateKey)&q=\(searchQuery)&days=1"
        
        // act
        let request = URLRequest(url: URL(string: endpoint)!)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case.failure(let appError):
                XCTFail("app error: \(appError)")
            // assert
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 15, "data should be bigger than 15K bytes or \(data.count)")
            }
        }
        // if we dont get our data in 5 seconds or less we just assume something went wrong.
        wait(for: [exp], timeout: 5.0)
    }
    
    func testFetchData() {
        // arrange
        let expectedWeatherCount = 1
        let exp = XCTestExpectation(description: "data found")
        let searchQuery = "New York".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        // act
        WeatherAPI.fetchRecipe(for: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
            // assert
            case .success(let weatherData):
                exp.fulfill()
                XCTAssertEqual(weatherData.count, expectedWeatherCount)
            }
        }
        wait(for: [exp], timeout: 5.0)
    }

}

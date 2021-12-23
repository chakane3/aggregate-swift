//
//  NetworkHelper.swift
//  SpotifySearch
//
//  Created by Chakane Shegog on 12/23/21.
//

import Foundation

class NetworkHelper {
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // this private initializer prevents an instance of URLSession to be used outside this file
    private init() {
        session = URLSession(configuration: .default)
    }
    
    // this function takes in a request of type URLRequest
    // theres a closure of type: (Result<Data, AppError>) -> ())
    // Result is a built-in enum in swift which best represents .success or .failure as an associated value
    // we'll take in the URL, then call the completion handler passing in data or return an error message
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            
            // check for network client error
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            
            // downcast URLResponse (response) to HTTPURLResponse
            // this gets us access to the statusCode property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap our data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // check out status code
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
            }
            
            // if nothing went wrong capture our data
            completion(.success(data))
        }
        dataTask.resume()
    }
}

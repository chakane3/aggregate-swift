//
//  NetworkHelper.swift
//  Books
//
//  Created by Chakane Shegog on 12/23/21.
//

import Foundation


class NetworkHelper {
    
    // create a shared instance of this class
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // we create a private initializer to prevent our instance of URLSession to be used outside this file
    private init() {
        session = URLSession(configuration: .default)
    }
    
    // This function takes in a request of type URLRequest
    // Theres a closure of type: (Result<Data, AppError>) -> ())
    // Result is an built-in enum in swift which represents .success or .failure as an associated value
    // We'll take in the url and call the completion handler passing in data or return an app error
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data,  AppError>) -> ()) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            // check network client error
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            // downcast URLResponse (response) to HTTPURLRequest to get access to the status code property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // check our status code
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            // if everything went fine, capture our data
            completion(.success(data))
        }
        dataTask.resume()
    }
}

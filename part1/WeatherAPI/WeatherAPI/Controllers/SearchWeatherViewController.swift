//
//  SearchWeatherViewController.swift
//  WeatherAPI
//
//  Created by Chakane Shegog on 12/24/21.
//

import UIKit

class SearchWeatherViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var weatherData: place? {
        didSet {
            loadData()
        }
    }
    
    var searchQuery: String = "California"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
    }
    
    func loadData() {
        WeatherAPI.fetchRecipe(for: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                fatalError("app error occured: \(appError)")
                
            case .success(let data):
                self.weatherData = data
            }
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        loadData()
        print("in SearchWeatherVC: \(weatherData)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weather" {
            let destinationVC = segue.destination as? WeatherDataViewController
            destinationVC?.detailWeatherData = weatherData
        }
    }
}

extension SearchWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss keyboard when user hits return
        textField.resignFirstResponder()
        
        // update the name of the our search query
        searchQuery = textField.text ?? "no name appears"
        return true
    }
}

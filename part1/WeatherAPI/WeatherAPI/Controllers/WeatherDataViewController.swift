//
//  WeatherDataViewController.swift
//  WeatherAPI
//
//  Created by Chakane Shegog on 12/24/21.
//

import UIKit

class WeatherDataViewController: UIViewController {
    
    var detailWeatherData: place?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(detailWeatherData ?? "nil")
 
    }
    
    
}

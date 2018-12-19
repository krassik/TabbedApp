//
//  FirstViewController.swift
//  Tabbed
//
//  Created by tati on 12/19/18.
//  Copyright © 2018 ps. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private lazy var controller = OpenWeatherMapNetworkController()
    
    @IBOutlet weak var weatherLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let cityName = textField.text,
            cityName.isEmpty == false else {
                print("Enter city name")
                return true
        }

        controller.fetchCurrentWeatherData(city: cityName) { (weatherData, error) in
            if let data = weatherData {
                let displayText = "City: \(cityName) \(data.condition) \(data.temperature) \(data.unit.rawValue)"
                self.weatherLabel.text = displayText
            }
            else {
                self.weatherLabel.text = "Not info for location: \(cityName)"
            }
        }
        
        return true
    }
}

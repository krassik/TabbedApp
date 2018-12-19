//
//  FirstViewController.swift
//  Tabbed
//
//  Created by tati on 12/19/18.
//  Copyright © 2018 ps. All rights reserved.
//

import UIKit

class WaetherViewController: UIViewController {
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension WaetherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let cityName = textField.text,
            cityName.isEmpty == false else {
                print("Enter city name")
                return true
        }

        return true
    }
}

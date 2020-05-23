//
//  ViewController.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let currentWeather = CurrentWeather()
        
        currentWeather.getCurrentWeather { (success) in
            if success{
                print("the City is: ", currentWeather.city);
            }
        }
        
    }

    
}


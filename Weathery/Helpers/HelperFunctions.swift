//
//  HelperFunctions.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import Foundation
import UIKit
func currentDateFromUNIX(unixDate: Double?) -> Date?{
    if unixDate != nil {
        return Date(timeIntervalSince1970: unixDate!)
    } else{
        return Date()
    }
}

func getWeatherIconFor(_ type: String) -> UIImage? { // return image is an optional because the retrieved code might not have an existing image
    return UIImage(named: type)
}

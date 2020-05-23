//
//  HelperFunctions.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import Foundation

func currentDateFromUNIX(unixDate: Double?) -> Date?{
    if unixDate != nil {
        return Date(timeIntervalSince1970: unixDate!)
    } else{
        return Date()
    }
}

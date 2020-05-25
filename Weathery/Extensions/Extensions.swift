//
//  Extensions.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import Foundation

extension Date{
    
    func shortDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
    
    func currentTimeFromDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}



//
//  HourlyForecast.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HourlyForecast{
    
    
    private var _date : Date!
    private var _temperature : Double!
    private var _weatherIcon: String!
    
    var date: Date{
        if _date == nil{
            _date = Date()
        }
        return _date
    }
    
    var temperature: Double{
        if _temperature == nil{
            _temperature = 0.0
        }
        return _temperature
    }
    
    var weatherIcon: String{
        if _weatherIcon == nil{
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>){
        
        let JSONResult = JSON(weatherDictionary)
        
        self._temperature = JSONResult["temp"].double
        self._date = currentDateFromUNIX(unixDate: JSONResult["ts"].double)
        self._weatherIcon = JSONResult["weather"]["icon"].stringValue
        
    }
    
    class func downloadHourlyForecastWeather(location: WeatherLocation, completion: @escaping(_ HourlyForecast:[HourlyForecast]) -> Void) {
        
        var HOURLYAPI_URL: String!
               
               if !location.isCurrentLocation{
                   HOURLYAPI_URL = String(format: "https://api.weatherbit.io/v2.0/forecast/hourly?city=%@,%@&hours=24&key=d8ac02651f7c4c74960405862d9fce66", location.city, location.countryCode)
               } else {
                   HOURLYAPI_URL = CURRENT_LOCATION_HOURLY_FORECAST_URL
               }
        
        Alamofire.request(HOURLYAPI_URL).responseJSON { (response) in
            let JSONResult = response.result
            
            var forecastArray: [HourlyForecast] = []
            
            if JSONResult.isSuccess{
                
                //Downcasting the JSONResult as a Dictionary
                if let dictionary = JSONResult.value as? Dictionary<String, AnyObject>{
                    //Taking only the "data" object from JSON
                    if let list = dictionary["data"] as? [Dictionary<String,AnyObject>]{
                        
                        //Appending each set of data for each hour into an Array
                        for item in list{
                            let forecast = HourlyForecast(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                    }
                }
                completion(forecastArray)
                
            } else {
                completion(forecastArray)
                print("No forecast available")
            }
        }
        
        
    }
    
}

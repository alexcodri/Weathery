//
//  WeeklyForecast.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class WeeklyWeatherForecast{
    
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
    
    class func downloadWeeklyWeatherForecast(location: WeatherLocation, completion: @escaping(_ weatherForecast: [WeeklyWeatherForecast]) -> Void){

    
        var WEEKLYFORECAST_URL: String!
                    
                    if !location.isCurrentLocation{
                        WEEKLYFORECAST_URL = String(format:    "https://api.weatherbit.io/v2.0/forecast/daily?city=%@,%@&days=7&key=d8ac02651f7c4c74960405862d9fce66", location.city, location.countryCode)
                    } else {
                        WEEKLYFORECAST_URL = CURRENT_LOCATION_WEEKLY_FORECAST_URL
                    }
             
        Alamofire.request(WEEKLYFORECAST_URL).responseJSON { (response) in
            
            let JSONResult = response.result
            
            var forecastArray : [WeeklyWeatherForecast] = []
            
            if JSONResult.isSuccess{
                
                if let dictionary = JSONResult.value as? Dictionary<String, AnyObject>{
                    if var list = dictionary["data"] as? [Dictionary<String, AnyObject>]{
                        //Removing the first element in the array because it is the current day, that is already parsed
                        list.remove(at: 0)
                        
                        for item in list{
                            let forecast = WeeklyWeatherForecast(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                    }
                }
                completion(forecastArray)
            } else {
                completion(forecastArray)
                print("No weekly forecasts!")
            }
            
        }
    }
}

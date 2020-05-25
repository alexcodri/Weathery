//
//  CurrentWeather.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather{
    
    
    //All the information the application will display
    
    private var _city : String! // it is not optional because we are required to have a city
    private var _date : Date! // -//- a date
    private var _currentTime : Double! // -//- the time
    private var _feelsLike : Double! // -//- the temperature
    private var _uv : Double!
    
    private var _weatherType : String!
    private var _currentTemperature: Double!
    private var _pressure : Double!
    private var _humidity : Double!
    private var _windSpeed : Double! // m/s
    private var _weatherIcon : String!
    private var _visibility : Double! // Km
    private var _sunrise : String!
    private var _sunset : String!
    
    //Getters for the private variables.
    
    var city: String{
        if _city == nil{
            _city = "" // just in case the API doesn't return any data for the city
        }
        return _city
    }
    
    var date: Date{
        if _date == nil{
            _date = Date()
        }
        return _date
    }
    
    var uv: Double{
        if _uv == nil{
            _uv = 0.0
        }
        return _uv
    }
    
    var sunrise: String{
        if _sunrise == nil{
            _sunrise = ""
        }
        return _sunrise
    }
    
    var sunset: String{
        if _sunset == nil{
            _sunset = ""
        }
        return _sunset
    }
    
    var currentTemperature: Double{
        if _currentTemperature == nil{
            _currentTemperature = 0.0
        }
        return _currentTemperature
    }
    
    var feelsLike: Double{
        if _feelsLike == nil{
            _feelsLike = 0.0
        }
        return _feelsLike
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var pressure: Double{
        if _pressure == nil{
            _pressure = 0.0
        }
        return _pressure
    }
    
    var humidity: Double{
        if _humidity == nil{
            _humidity = 0.0
        }
        return _humidity
    }
    
    var windSpeed: Double{
        if _windSpeed == nil{
            _windSpeed = 0.0
        }
        return _windSpeed
    }
    
    var weatherIcon: String{
        if _weatherIcon == nil{
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    var visibility: Double{
        if _visibility == nil{
            _visibility = 0.0
        }
        return _visibility
    }
    
    func getCurrentWeather(location: WeatherLocation,completion: @escaping(_ success: Bool) -> Void){
        var LOCATIONAPI_URL: String!
        
        if !location.isCurrentLocation{
            LOCATIONAPI_URL = String(format: "https://api.weatherbit.io/v2.0/current?city=%@,%@&key=d8ac02651f7c4c74960405862d9fce66", location.city, location.countryCode)
        } else {
            LOCATIONAPI_URL = CURRENT_LOCATION_URL
        }
            
        Alamofire.request(LOCATIONAPI_URL).responseJSON { (response) in
            
            let result = response.result
            
            if result.isSuccess {
                
                let resultJSON = JSON(result.value!)
                
                //Parsing JSON and assigning variables.
                self._city = resultJSON["data"][0]["city_name"].stringValue
                
                //the Date from the API comes in UNIX Time, hence there is needed a Helper function.
                self._date = currentDateFromUNIX(unixDate: resultJSON["data"][0]["ts"].double)
                
                self._weatherType = resultJSON["data"][0]["weather"]["description"].stringValue
                
                self._currentTemperature = resultJSON["data"][0]["temp"].double
                
                self._feelsLike = resultJSON["data"][0]["app_temp"].double
                
                self._pressure = resultJSON["data"][0]["pres"].double
                
                self._humidity = resultJSON["data"][0]["rh"].double
                
                self._windSpeed = resultJSON["data"][0]["wind_spd"].double
                
                self._weatherIcon = resultJSON["data"][0]["weather"]["icon"].stringValue
                
                self._visibility = resultJSON["data"][0]["vis"].double
                
                self._uv = resultJSON["data"][0]["uv"].double
                
                self._sunrise = resultJSON["data"][0]["sunrise"].stringValue
                
                self._sunset = resultJSON["data"][0]["sunset"].stringValue
                //If the download was successful, completion will be marked as true.
                completion(true)
                
            } else {
                
                completion(false)
                
                print("no result found for current location")
            }
        }
    }
}

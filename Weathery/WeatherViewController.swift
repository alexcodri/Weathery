//
//  WeatherViewController.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var weatherScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var weatherLocation: WeatherLocation!
    
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     override func viewDidAppear(_ animated: Bool) {
        let weatherView = WeatherView()
        weatherView.frame = CGRect(x: 0, y: 0, width: weatherScrollView.bounds.width, height: weatherScrollView.bounds.height)
        weatherScrollView.addSubview(weatherView)
        
        weatherLocation = WeatherLocation(city: "Bucharest", country: "Romania", countryCode: "RO", isCurrentLocation: false)
        
        getCurrentWeather(weatherView: weatherView)
        getHourlyWeather(weatherView: weatherView)
        getWeeklyWeather(weatherView: weatherView)
    }
    

    //MARK: Download weather data
    //There will be three functions, for each model
    
    private func getCurrentWeather(weatherView: WeatherView){
        weatherView.currentWeather = CurrentWeather()
        
        weatherView.currentWeather.getCurrentWeather(location: weatherLocation) { (success) in
            weatherView.refreshData()
        }
    }
    
    private func getWeeklyWeather(weatherView: WeatherView){
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast(location: weatherLocation) { (weeklyForecasts) in
            weatherView.weeklyWeatherForecastData = weeklyForecasts
            weatherView.tableView.reloadData()
        }
    }
    
    private func getHourlyWeather(weatherView: WeatherView){
        HourlyForecast.downloadHourlyForecastWeather(location: weatherLocation) { (hourlyForecasts) in
            weatherView.dailyWeatherForecastData = hourlyForecasts
            weatherView.hourlyWeatherCollectionView.reloadData()
        }
    }
    

}

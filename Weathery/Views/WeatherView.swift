//
//  WeatherView.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import UIKit

class WeatherView: UIView{
    
    //MARK: IBOutlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureInfoLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var hourlyWeatherCollectionView: UICollectionView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var currentWeather: CurrentWeather!
    var weeklyWeatherForecastData: [WeeklyWeatherForecast] = []
    var dailyWeatherForecastData: [HourlyForecast] = []
    var weatherInfoData: [WeatherInfo] = []
    
    //MAKR: INITs
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func mainInit(){
        //initializing nib
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        //loading the MainView from .xib
        addSubview(mainView)
        //the frame will be the screen size
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        setupTableView()
        setupHourlyCollectionView()
        setupInfoCollectionView()
    }
    //MARK: setting components
    private func setupTableView(){
    
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setupHourlyCollectionView(){
        hourlyWeatherCollectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: Bundle.main),
                                             forCellWithReuseIdentifier: "cell")
        hourlyWeatherCollectionView.dataSource = self
    }
    
    private func setupInfoCollectionView(){
        infoCollectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: Bundle.main),
                                             forCellWithReuseIdentifier: "cell")
        infoCollectionView.dataSource = self
    }
    
    func refreshData(){ // creating the function because setupCurrentWeather is private.
        setupCurrentWeather()
        setupWeatherInfo()
        infoCollectionView.reloadData()
    }
    
    private func setupCurrentWeather(){
        cityNameLabel.text = currentWeather.city
        dateLabel.text = "Today, \(currentWeather.date.shortDate())" //Creating an extension in order to display the date as "Feb 7".
        weatherInfoLabel.text = currentWeather.weatherType
        temperatureInfoLabel.text =  "\(currentWeather.currentTemperature)"
    }
    
    private func setupWeatherInfo(){
        let windInfo = WeatherInfo(infoText: String(format: "%.1fm/s",currentWeather.windSpeed), nameTextInfo: nil, image: getWeatherIconFor("wind"))
        let humidity = WeatherInfo(infoText: "\(currentWeather.humidity)", nameTextInfo: nil, image: getWeatherIconFor("humidity"))
        let pressureInfo = WeatherInfo(infoText: String(format: "%.0fmb",currentWeather.pressure), nameTextInfo: nil, image: getWeatherIconFor("pressure"))
        let visibilityInfo = WeatherInfo(infoText: String(format: "%.1fkm",currentWeather.windSpeed), nameTextInfo: nil, image: getWeatherIconFor("visibility"))
        let feelsLike = WeatherInfo(infoText: String(format: "%.1f",currentWeather.feelsLike), nameTextInfo: nil, image: getWeatherIconFor("feelsLike"))
        let uvInfo = WeatherInfo(infoText: String(format: "%.0f",currentWeather.uv), nameTextInfo: "UV Index", image: nil)
        let sunrise = WeatherInfo(infoText: currentWeather.sunrise, nameTextInfo: nil, image: getWeatherIconFor("sunrise"))
        let sunset = WeatherInfo(infoText: currentWeather.sunset, nameTextInfo: nil, image: getWeatherIconFor("sunset"))
        
        weatherInfoData = [windInfo,humidity,pressureInfo,visibilityInfo,feelsLike,uvInfo,sunrise,sunset]
    }
}

    //MARK: Extensions
extension WeatherView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherForecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.generateCell(forecast: weeklyWeatherForecastData[indexPath.row])//Generating the custom cell
        return cell
    }
    

}

extension WeatherView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Because there are TWO collectionViews we can reffer to, we need to handle which collectionView is being reffered to.
        if collectionView == hourlyWeatherCollectionView{
            return dailyWeatherForecastData.count
        } else {
            return weatherInfoData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       //Same problem here, we need to handle which collectionView is being refferd to.
        if collectionView == hourlyWeatherCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ForecastCollectionViewCell
            cell.generateCell(weather: dailyWeatherForecastData[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfoCollectionViewCell
            cell.generateCell(weatherInfo: weatherInfoData[indexPath.row])
            return cell
        }
    }
    
    
}


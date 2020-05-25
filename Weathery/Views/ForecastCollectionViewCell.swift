//
//  ForecastCollectionViewCell.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: Functions
    func generateCell(weather: HourlyForecast){ //Generate a cell for the coresponding hourly forecast
        timeLabel.text = weather.date.currentTimeFromDate() // creating an extention
        weatherImage.image = getWeatherIconFor(weather.weatherIcon) // global function because DRY
        temperatureLabel.text = "\(weather.temperature)"
    }
}

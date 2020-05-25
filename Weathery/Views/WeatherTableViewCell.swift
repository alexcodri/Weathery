//
//  WeatherTableViewCell.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    //MARK: IBOutlets

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func generateCell(forecast: WeeklyWeatherForecast){
        dayOfWeekLabel.text = forecast.date.dayOfTheWeek() //function that returns only the day from the date
        weatherImageView.image = getWeatherIconFor(forecast.weatherIcon)
        temperatureLabel.text = "\(forecast.temperature)"
    }
    
}

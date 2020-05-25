//
//  InfoCollectionViewCell.swift
//  Weathery
//
//  Created by Alex Codreanu on 23/05/2020.
//  Copyright © 2020 Alex Codreanu. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    func generateCell(weatherInfo: WeatherInfo){// This function will handle the hourly forecast cells that contain weather conditions
        infoLabel.text = weatherInfo.infoText
        infoLabel.adjustsFontSizeToFitWidth = true // in case the text will be too big to fit in the label on its own
        
        if weatherInfo.image != nil{
            nameLabel.isHidden = true // when we have an image, we do not need the text
            infoImageView.isHidden = false
            infoImageView.image = weatherInfo.image
        } else {
            nameLabel.isHidden = false
            infoImageView.isHidden = true
            nameLabel.adjustsFontSizeToFitWidth = true
            nameLabel.text = weatherInfo.nameTextInfo
        }
        
    }
}

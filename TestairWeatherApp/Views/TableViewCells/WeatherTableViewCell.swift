//
//  WeatherTableViewCell.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeatherTableViewCell"
    static let nib = "WeatherTableViewCell"
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 20
            super.frame = frame
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }

}

extension WeatherTableViewCell: WeatherPresenterDelegate {
    func showWeather(description: String, temperature: Int, date: String, name: String, icon: String) {
        descriptionLabel.text = description
        temperatureLabel.text = String(temperature)
        cityLabel.text = name
        dateLabel.text = date
    }
    
    
}

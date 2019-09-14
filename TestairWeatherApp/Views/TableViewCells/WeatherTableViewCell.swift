//
//  WeatherTableViewCell.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit

protocol WeatherCell: class {
    func showWeather(description: String,
                     temperature: Int64,
                     date: String,
                     name: String,
                     icon: Data)
}

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

extension WeatherTableViewCell: WeatherCell {
    func showWeather(description: String, temperature: Int64, date: String, name: String, icon: Data) {
        descriptionLabel.text = description.capitalized
        temperatureLabel.text = String(temperature)
        dateLabel.text = date
        cityLabel.text = name
        iconImageView.image = UIImage(data: icon)
    }
}


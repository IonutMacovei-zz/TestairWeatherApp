//
//  ListWeatherPresenter.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import Foundation

final class ListWeatherPresenter {
    private weak var view: ListWeatherView?
    
    var weatherModel: [CityWeather?] = [] {
        didSet {
            view?.redraw()
        }
    }
    
    var count: Int {
        if weatherModel.count > 5 {
            return weatherModel.count - 1
        } else {
            return weatherModel.count
        }
    }
    
    init(weatherModel: [CityWeather]) {
        self.weatherModel = weatherModel
    }
    
    func setView(_ view: ListWeatherView) {
        self.view = view
    }
    
    func configure(cell: WeatherTableViewCell, row: Int) {
        let weather = weatherModel[row]
        cell.showWeather(description: weather?.weather_description ?? "",
                         temperature: weather?.temperature ?? 0,
                         date: weather?.date ?? "",
                         name: weather?.name ?? "",
                         icon: weather?.icon ?? Data())
    }
    
    deinit {
        weatherModel = []
    }
    
}

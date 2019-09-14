//
//  ListWeatherPresenter.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import Foundation

protocol ListWeatherView: class {
    func show(name: String, icon: String)
    func showWeather(description: String,
                     temperature: Int,
                     date: String,
                     name: String,
                     icon: Data)
}

final class ListWeatherPresenter {
    private weak var view: ListWeatherView?
    var weatherModel: WeatherModel? {
        didSet {
            guard let weatherModel = weatherModel else { return }
            view?.showWeather(description: weatherModel.weather.description,
                              temperature: weatherModel.temperature,
                              date: weatherModel.date,
                              name: weatherModel.name,
                              icon: weatherModel.icon)
        }
    }
    
    var count: Int {
        return 1
    }
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
    
    func setView(_ view: ListWeatherView) {
        self.view = view
    }
    
    func configure(cell: WeatherTableViewCell, row: Int) {
        cell.showWeather(description: weatherModel?.weather.description ?? "",
                         temperature: weatherModel?.temperature ?? 0,
                         date: weatherModel?.date ?? "",
                         name: weatherModel?.name ?? "",
                         icon: weatherModel!.icon)
    }
}

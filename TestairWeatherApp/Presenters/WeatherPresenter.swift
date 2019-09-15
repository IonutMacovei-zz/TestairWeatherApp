//
//  WeatherPresenter.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import Foundation

class WeatherPresenter {
    var model: WeatherModel!
    private weak var view: WeatherView?

    func loadWeatherFor(city: String, completion: @escaping (_ success: Bool) -> Void) {
        Service.shared.fetchWeatherData(city: city) { (weatherData, error) in
            let imageData = Service.shared.loadIcon(icon: weatherData?.weather.first?.icon ?? "")
            self.model = WeatherModel(description: weatherData?.weather.first?.description,
                                      temperature: weatherData?.main.temp,
                                      dt: weatherData?.dt,
                                      name: weatherData?.name,
                                      icon: imageData)
            DispatchQueue.main.async {
                ContextHandler.createData(from: self.model)
            }
            completion(true)
        }

    }
    
    func setView(_ view: WeatherView) {
        self.view = view
    }
    
    func showDetails() {
        DispatchQueue.main.async {
            let model = ContextHandler.retrieveData()
            if model.count != 0 {
                let nextPresenter = ListWeatherPresenter(weatherModel: model)
                self.view?.moveTo(nextPresenter: nextPresenter)
            }
        }
    }
    
}

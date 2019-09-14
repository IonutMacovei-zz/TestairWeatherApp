//
//  WeatherPresenter.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import Foundation

protocol WeatherPresenterDelegate: class {
    func showWeather(description: String,
                     temperature: Int,
                     date: String,
                     name: String,
                     icon: String)
}

class WeatherPresenter {
    var model: WeatherModel!
    weak var delegate: WeatherPresenterDelegate?
    
    func loadWeatherFor(city: String) {
        let baseUrl = "http://api.openweathermap.org/data/2.5/weather?q=\(city),LTU&appid=7587eaff3affbf8e56a81da4d6c51d06"
        
        guard let url = URL(string: baseUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(Location.self, from: data)
                self.model = WeatherModel(weather: weatherData.weather,
                                          main: weatherData.main,
                                          dt: weatherData.dt,
                                          name: weatherData.name,
                                          icon: weatherData.weather.first!.icon)
            } catch let err {
                print(err)
            }
        }.resume()
    }
}

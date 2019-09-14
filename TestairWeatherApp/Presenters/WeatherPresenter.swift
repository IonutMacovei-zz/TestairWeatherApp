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
                     icon: Data)
}

class WeatherPresenter {
    var model: WeatherModel!
    private weak var view: WeatherView?

    func loadWeatherFor(city: String, completion: @escaping (_ success: Bool) -> Void) {
        let baseUrl = "http://api.openweathermap.org/data/2.5/weather?q=\(city),LTU&appid=7587eaff3affbf8e56a81da4d6c51d06"
        guard let url = URL(string: baseUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(Location.self, from: data)
                let imageData = self.loadIcon(icon: weatherData.weather.first?.icon ?? "")
                self.model = WeatherModel(weather: weatherData.weather.first,
                                          main: weatherData.main,
                                          dt: weatherData.dt,
                                          name: weatherData.name,
                                          icon: imageData)
                completion(true)
            } catch let err {
                print(err)
                completion(false)
            }
        }.resume()
    }
    
    func setView(_ view: WeatherView) {
        self.view = view
    }
    
    func showDetails() {
        DispatchQueue.main.async {
            guard let model = self.model else { return }
            let nextPresenter = ListWeatherPresenter(weatherModel: model)
            self.view?.showDetails(nextPresenter: nextPresenter)
        }
    }
    
    private func loadIcon(icon: String) -> Data {
        let imageString = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        guard let url = URL(string: imageString) else { return Data() }
        if let data = try? Data(contentsOf: url) {
            return data
        } else {
            return Data()
        }
    }
}

//
//  WeatherModel.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

struct WeatherModel {
    let weather: [Weather]!
    let main: Main!
    let dt: Int!
    let name: String!
    
    var temperature: Int {
        return Int(main.temp - 273.15)
    }
    
    var date: String {
        return dt.dayMonth
    }
}

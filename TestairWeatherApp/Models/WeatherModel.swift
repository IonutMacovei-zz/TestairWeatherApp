//
//  WeatherModel.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//
import Foundation
import Darwin

struct WeatherModel {
    let weather: Weather!
    let main: Main!
    let dt: Int!
    let name: String!
    let icon: Data!
    
    var temperature: Int {
        return Int(main.temp - 273.15)
    }
    
    var date: String {
        return dt.monthDay
    }
}

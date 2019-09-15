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
    let description: String!
    let temperature: Double!
    let dt: Int!
    let name: String!
    let icon: Data!
    
    var tempCelsius: Int {
        return Int(temperature - 273.15)
    }
    
    var date: String {
        return dt.monthDay
    }
}

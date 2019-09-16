//
//  Service.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 15/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import Foundation

class Service: NSObject {
    
    static let shared = Service()
    
    func fetchWeatherData(city: String,completion: @escaping (Location?, Error?) -> ()) {
        let baseUrl = "http://api.openweathermap.org/data/2.5/weather?q=\(city),LTU&appid=7587eaff3affbf8e56a81da4d6c51d06"
        guard let url = URL(string: baseUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch:", err)
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Location.self, from: data)
                DispatchQueue.main.async {
                    completion(weather, nil)
                }
            } catch let jsonErr {
                completion(nil, jsonErr)
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
    
    func loadIcon(icon: String) -> Data {
        let imageString = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        guard let url = URL(string: imageString) else { return Data() }
        if let data = try? Data(contentsOf: url) {
            return data
        } else {
            return Data()
        }
    }
}

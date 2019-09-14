//
//  ContextHandler.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataKey {
    static let description = "weather_description"
    static let date = "date"
    static let icon = "icon"
    static let name = "name"
    static let temperature = "temperature"
}

class ContextHandler {
    private static let shared = ContextHandler()
    
    private let mainPersistentContainer: NSPersistentContainer
    
    var contextArray: [CityWeather] = []

    static var currentContext: NSManagedObjectContext {
        return ContextHandler.shared.mainPersistentContainer.viewContext
    }
    
    static var entityName: String {
        return "CityWeather"
    }
    
    static func createData(from model: WeatherModel) {
        let context = ContextHandler.currentContext
        let weatherEntity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        
        let weather = NSManagedObject(entity: weatherEntity, insertInto: context)
        weather.setValue(model.weather.description, forKey: CoreDataKey.description)
        weather.setValue(model.date, forKey: CoreDataKey.date)
        weather.setValue(model.icon, forKey: CoreDataKey.icon)
        weather.setValue(model.name, forKey: CoreDataKey.name)
        weather.setValue(model.temperature, forKey: CoreDataKey.temperature)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func retrieveData() -> [CityWeather] {
        let context = ContextHandler.currentContext
        let fetchRequest = NSFetchRequest<CityWeather>(entityName: entityName)
        var contextArray = ContextHandler.shared.contextArray
        fetchRequest.fetchLimit = 6
        do {
            let result = try context.fetch(fetchRequest)
            for data in result {
                contextArray.append(data)
                print(data.value(forKey: CoreDataKey.name) as! String)
            }
            // Data is deleted only when are more than 5 objects
            deleteData()
            return contextArray.reversed()
        } catch {
            print("Failed")
        }
        return []
    }
    
    static func deleteData(){
        let context = ContextHandler.currentContext
        let fetchRequest = NSFetchRequest<CityWeather>(entityName: entityName)
        do {
            let test = try context.fetch(fetchRequest)
            guard let objectToDelete = test.first else { return }
            if test.count > 5 {
                context.delete(objectToDelete)
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        mainPersistentContainer = appDelegate.persistentContainer
        contextArray = []
    }
}

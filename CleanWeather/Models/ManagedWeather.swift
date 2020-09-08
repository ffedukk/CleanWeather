//
//  ManagedWeather.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation
import CoreData

@objc(ManagedWeather)
public class ManagedWeather: NSManagedObject {
    
    public class func create(weatherData: [String : Any], forecastData: [[String : Any]], managedContext: NSManagedObjectContext) -> ManagedWeather {
        let weather = ManagedWeather(context: managedContext)
        weather.placeName = weatherData["name"] as? String
        weather.feelsLike = weatherData["feelsLike"] as! Double
        weather.icon = weatherData["weather"] as? String
        weather.weatherDescription = weatherData["weatherDescription"] as? String
        weather.temperature = weatherData["temp"] as! Double
        weather.temperatureMax = weatherData["tempMax"] as! Double
        weather.temperatureMin = weatherData["tempMin"] as! Double
        weather.pressure = weatherData["pressure"] as! Double
        weather.windSpeed = weatherData["windSpeed"] as! Double
        weather.sunset = Int64(weatherData["sunset"] as! Int)
        weather.sunrise = Int64(weatherData["sunrise"] as! Int)
        weather.managedForecast = []
        
        for interval in forecastData {
            ManagedForecast.create(dict: interval, weather: weather, managedContext: managedContext)
        }
        return weather
    }
    
    public class func update(weather: ManagedWeather, weatherData: [String : Any], forecastData: [[String : Any]], managedContext: NSManagedObjectContext) -> ManagedWeather {
    
        weather.placeName = weatherData["name"] as? String
        weather.feelsLike = weatherData["feelsLike"] as! Double
        weather.icon = weatherData["weather"] as? String
        weather.weatherDescription = weatherData["weatherDescription"] as? String
        weather.temperature = weatherData["temp"] as! Double
        weather.temperatureMax = weatherData["tempMax"] as! Double
        weather.temperatureMin = weatherData["tempMin"] as! Double
        weather.pressure = weatherData["pressure"] as! Double
        weather.windSpeed = weatherData["windSpeed"] as! Double
        weather.sunset = Int64(weatherData["sunset"] as! Int)
        weather.sunrise = Int64(weatherData["sunrise"] as! Int)
        
        for forecast in weather.managedForecast!.array {
            ManagedForecast.delete(forecast: forecast as! ManagedForecast, managedContext: managedContext)
        }
        
        for interval in forecastData {
            ManagedForecast.create(dict: interval, weather: weather, managedContext: managedContext)
        }
        return weather
    }
    
    public class func delete(weather: ManagedWeather, managedContext: NSManagedObjectContext) {
        for forecast in weather.managedForecast!.array {
            ManagedForecast.delete(forecast: forecast as! ManagedForecast, managedContext: managedContext)
        }
        managedContext.delete(weather)
    }
}

extension ManagedWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedWeather> {
        return NSFetchRequest<ManagedWeather>(entityName: "ManagedWeather")
    }

    @NSManaged public var feelsLike: Double
    @NSManaged public var placeName: String?
    @NSManaged public var pressure: Double
    @NSManaged public var sunrise: Int64
    @NSManaged public var sunset: Int64
    @NSManaged public var temperature: Double
    @NSManaged public var temperatureMax: Double
    @NSManaged public var temperatureMin: Double
    @NSManaged public var icon: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var managedForecast: NSOrderedSet?

}

// MARK: Generated accessors for forecast
extension ManagedWeather {

    @objc(insertObject:inForecastAtIndex:)
    @NSManaged public func insertIntoForecast(_ value: ManagedForecast, at idx: Int)

    @objc(removeObjectFromForecastAtIndex:)
    @NSManaged public func removeFromForecast(at idx: Int)

    @objc(insertForecast:atIndexes:)
    @NSManaged public func insertIntoForecast(_ values: [ManagedForecast], at indexes: NSIndexSet)

    @objc(removeForecastAtIndexes:)
    @NSManaged public func removeFromForecast(at indexes: NSIndexSet)

    @objc(replaceObjectInForecastAtIndex:withObject:)
    @NSManaged public func replaceForecast(at idx: Int, with value: ManagedForecast)

    @objc(replaceForecastAtIndexes:withForecast:)
    @NSManaged public func replaceForecast(at indexes: NSIndexSet, with values: [ManagedForecast])

    @objc(addForecastObject:)
    @NSManaged public func addToForecast(_ value: ManagedForecast)

    @objc(removeForecastObject:)
    @NSManaged public func removeFromForecast(_ value: ManagedForecast)

    @objc(addForecast:)
    @NSManaged public func addToForecast(_ values: NSOrderedSet)

    @objc(removeForecast:)
    @NSManaged public func removeFromForecast(_ values: NSOrderedSet)

}

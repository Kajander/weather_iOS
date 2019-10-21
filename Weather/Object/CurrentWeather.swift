//
//  currentWeather.swift
//  Weather
//
//  Created by Joakim Kajan on 28.02.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    let time: Double?
    let summary: String?
    let icon: String?
    let nearestStormDistance: Double? // The approximate distance to the nearest storm in miles. (A storm distance of 0 doesn’t necessarily refer to a storm at the requested location, but rather a storm in the vicinity of that location.)
    let precipIntensity: Double?
    let precipIntensityError: Double?
    let precipProbability: Double?
    let precipType: String?
    let temperature: Double? // The air temperature in degrees Fahrenheit.

    let apparentTemperature: Double?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windGust: Double?
    let windBearing: Int?
    let cloudCover: Double?
    let uvIndex: Int?
    let visibility: Double?
    let ozone: Double? // The columnar density of total atmospheric ozone at the given time in Dobson units.

    
    struct CurrentWeatherKeys {
        
        static let time = "time"
        static let summary = "summary"
        static let icon = "icon"
        static let nearestStormDistance = "nearestStormDistance"
        static let precipIntensity = "precipIntensity"
        static let precipIntensityError = "precipIntensityError"
        static let precipProbability = "precipProbability"
        static let precipType = "precipType"
        static let temperature = "temperature"
        static let apparentTemperature = "apparentTemperature"
        static let dewPoint = "dewPoint"
        static let humidity = "humidity"
        static let pressure = "pressure"
        static let windSpeed = "windSpeed"
        static let windGust = "windGust"
        static let windBearing = "windBearing"
        static let cloudCover = "cloudCover"
        static let uvIndex = "uvIndex"
        static let visibility = "visibility"
        static let ozone = "ozone"
        
    }
    
    
    init(currentWeatherDictionary: [String: Any]) {
        
        time = currentWeatherDictionary[CurrentWeatherKeys.time] as? Double
        summary = currentWeatherDictionary[CurrentWeatherKeys.summary] as? String
        icon = currentWeatherDictionary[CurrentWeatherKeys.icon] as? String
        nearestStormDistance = currentWeatherDictionary[CurrentWeatherKeys.nearestStormDistance] as? Double
        precipIntensity = currentWeatherDictionary[CurrentWeatherKeys.precipIntensity] as? Double
        precipIntensityError = currentWeatherDictionary[CurrentWeatherKeys.precipIntensityError] as? Double
        precipProbability = currentWeatherDictionary[CurrentWeatherKeys.precipProbability] as? Double
        precipType = currentWeatherDictionary[CurrentWeatherKeys.precipType] as? String
        temperature = currentWeatherDictionary[CurrentWeatherKeys.temperature] as? Double
        apparentTemperature = currentWeatherDictionary[CurrentWeatherKeys.apparentTemperature] as? Double
        dewPoint = currentWeatherDictionary[CurrentWeatherKeys.dewPoint] as? Double
        humidity = currentWeatherDictionary[CurrentWeatherKeys.humidity] as? Double
        pressure = currentWeatherDictionary[CurrentWeatherKeys.pressure] as? Double
        windSpeed = currentWeatherDictionary[CurrentWeatherKeys.windSpeed] as? Double
        windGust = currentWeatherDictionary[CurrentWeatherKeys.windGust] as? Double
        windBearing = currentWeatherDictionary[CurrentWeatherKeys.windBearing] as? Int
        cloudCover = currentWeatherDictionary[CurrentWeatherKeys.cloudCover] as? Double
        uvIndex = currentWeatherDictionary[CurrentWeatherKeys.uvIndex] as? Int
        visibility = currentWeatherDictionary[CurrentWeatherKeys.visibility] as? Double
        ozone = currentWeatherDictionary[CurrentWeatherKeys.ozone] as? Double
        
    }
}

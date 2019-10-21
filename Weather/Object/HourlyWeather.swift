//
//  HourlyWeather.swift
//  Weather
//
//  Created by Joakim Kajan on 28.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import Foundation

class HourlyWeather {
    
    let time: Double?
    let summary: String?
    let icon: String?
    let precipIntensity: Double?
    let precipProbability: Double?
    let precipType: String?
    let temperature: Double?
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
    let ozone: Double?
    


    struct HourlyWeatherKeys {
        
        static let time = "time"
        static let summary = "summary"
        static let icon = "icon"
        static let precipIntensity = "precipIntensity"
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

    init(hourlyWeatherDictionary: [String: Any]) {

        time = hourlyWeatherDictionary[HourlyWeatherKeys.time] as? Double
        summary = hourlyWeatherDictionary[HourlyWeatherKeys.summary] as? String
        icon =  hourlyWeatherDictionary[HourlyWeatherKeys.icon] as? String
        precipIntensity = hourlyWeatherDictionary[HourlyWeatherKeys.precipIntensity] as? Double
        precipProbability = hourlyWeatherDictionary[HourlyWeatherKeys.precipProbability] as? Double
        precipType = hourlyWeatherDictionary[HourlyWeatherKeys.precipType] as? String
        temperature = hourlyWeatherDictionary[HourlyWeatherKeys.temperature] as? Double
        apparentTemperature = hourlyWeatherDictionary[HourlyWeatherKeys.apparentTemperature] as? Double
        
        dewPoint = hourlyWeatherDictionary[HourlyWeatherKeys.dewPoint] as? Double
        humidity = hourlyWeatherDictionary[HourlyWeatherKeys.humidity] as? Double
        pressure = hourlyWeatherDictionary[HourlyWeatherKeys.pressure] as? Double
        windSpeed = hourlyWeatherDictionary[HourlyWeatherKeys.windSpeed] as? Double
        windGust = hourlyWeatherDictionary[HourlyWeatherKeys.windGust] as? Double
        windBearing = hourlyWeatherDictionary[HourlyWeatherKeys.windBearing] as? Int
        cloudCover = hourlyWeatherDictionary[HourlyWeatherKeys.cloudCover] as? Double
        uvIndex = hourlyWeatherDictionary[HourlyWeatherKeys.uvIndex] as? Int
        visibility = hourlyWeatherDictionary[HourlyWeatherKeys.visibility] as? Double
        ozone = hourlyWeatherDictionary[HourlyWeatherKeys.ozone] as? Double
    }
}


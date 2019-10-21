//
//  DailyWeather.swift
//  Weather
//
//  Created by Joakim Kajan on 14.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import Foundation

class DailyWeather {
    
    let time: Double? // The UNIX time at which this data point begins. minutely data point are always aligned to the top of the minute, hourly data point objects to the top of the hour, and daily data point objects to midnight of the day, all according to the local time zone.
    let summary: String? // A human-readable text summary of this data point.
    let icon: String? // A machine-readable text summary of this data point, suitable for selecting an icon for display. If defined, this property will have one of the following values: clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
    let sunriseTime: Double? // The UNIX time of when the sun will rise during a given day.
    let sunsetTime: Double? // The UNIX time of when the sun will set during a given day.
    let moonPhase: Double? // 0 corresponds to a new moon, 0.25 to a first quarter moon, 0.5 to a full moon, and 0.75 to a last quarter moon.
    
    
    let precipIntensity: Double? // The intensity (in inches of liquid water per hour) of precipitation occurring at the given time. This value is conditional on probability (that is, assuming any precipitation occurs at all).
    let precipIntensityMax: Double? // The maximum value of precipIntensity during a given day.
    let precipIntensityMaxTime: Int? // The UNIX time of when precipIntensityMax occurs during a given day.
    let precipProbability: Double? // The probability of precipitation occurring, between 0 and 1, inclusive.
    let precipType: String? // The type of precipitation occurring at the given time. If defined, this property will have one of the following values: "rain", "snow", or "sleet"
    
    
    let temperatureHigh: Double? // The daytime high temperature.
    let temperatureHighTime: Int? // The UNIX time representing when the daytime high temperature occurs.
    let temperatureLow: Double? // The overnight low temperature.
    let temperatureLowTime: Int? // The UNIX time representing when the overnight low temperature occurs.

    let apparentTemperatureHigh: Double? // The daytime "feels-like" high temperature.
    let apparentTemperatureHighTime: Int? // The UNIX time representing when the daytime "feels-like" high temperature occurs.
    let apparentTemperatureLow: Double? // The daytime "feels-like" low temperature.
    let apparentTemperatureLowTime: Int? // The UNIX time representing when the daytime "feels-like" low temperature occurs.
    
    let temperatureMin: Double? // The minimum temperature during a given date.
    let temperatureMinTime: Int? // The UNIX time representing when the minimum temperature during a given date occurs.
    let temperatureMax: Double? // The maximum temperature during a given date.
    let temperatureMaxTime: Int? // The UNIX time representing when the maximum temperature during a given date occurs.

    let apparentTemperatureMin: Double? // The minimum "feels-like" temperature during a given date.
    let apparentTemperatureMinTime: Int? // The UNIX time representing when the minimum "feels-like" temperature during a given date occurs.
    let apparentTemperatureMax: Double? // The maximum "feels-like" temperature during a given date.
    let apparentTemperatureMaxTime: Int? // The UNIX time representing when the maximum "feels-like" temperature during a given date occurs.
    
    let dewPoint: Double? // The dew point in degrees Fahrenheit.
    let humidity: Double? // The relative humidity, between 0 and 1, inclusive.
    let pressure: Double? // The sea-level air pressure in millibars.

    let windSpeed: Double? // The wind speed in miles per hour.
    let windGust: Double? // The wind gust speed in miles per hour.
    let windGustTime: Int? // The time at which the maximum wind gust speed occurs during the day.
    let windBearing: Int? // The direction that the wind is coming from in degrees, with true north at 0° and progressing clockwise. (If windSpeed is zero, then this value will not be defined.)

    let cloudCover: Double? // The percentage of sky occluded by clouds, between 0 and 1, inclusive.
    let uvIndex: Int? // The UV index.
    let uvIndexTime: Int? // The UNIX time of when the maximum uvIndex occurs during a given day.
    let visibility: Int? // The average visibility in miles, capped at 10 miles.
    let ozone: Double? // The columnar density of total atmospheric ozone at the given time in Dobson units.

    struct DailyWeatherKeys {
        
        static let time = "time"
        static let summary = "summary"
        static let icon = "icon"
        static let sunriseTime = "sunriseTime"
        static let sunsetTime = "sunsetTime"
        static let moonPhase = "moonPhase"
        
        static let precipIntensity = "precipIntensity"
        static let precipIntensityMax = "precipIntensityMax"
        static let precipIntensityMaxTime = "precipIntensityMaxTime"
        static let precipProbability = "precipProbability"
        static let precipType = "precipType"
        
        static let temperatureHigh = "temperatureHigh"
        static let temperatureHighTime = "temperatureHighTime"
        static let temperatureLow = "temperatureLow"
        static let temperatureLowTime = "temperatureLowTime"
        static let apparentTemperatureHigh = "apparentTemperatureHigh"
        static let apparentTemperatureHighTime = "apparentTemperatureHighTime"
        static let apparentTemperatureLow = "apparentTemperatureLow"
        static let apparentTemperatureLowTime = "apparentTemperatureLowTime"
        
        static let temperatureMin = "temperatureMin"
        static let temperatureMinTime = "temperatureMinTime"
        static let temperatureMax = "temperatureMax"
        static let temperatureMaxTime = "temperatureMaxTime"
        static let apparentTemperatureMin = "apparentTemperatureMin"
        static let apparentTemperatureMinTime = "apparentTemperatureMinTime"
        static let apparentTemperatureMax = "apparentTemperatureMax"
        static let apparentTemperatureMaxTime = "apparentTemperatureMaxTime"
        
        static let dewPoint = "dewPoint"
        static let humidity = "humidity"
        static let pressure = "pressure"
        static let windSpeed = "windSpeed"
        static let windGust = "windGust"
        static let windGustTime = "windGustTime"
        static let windBearing = "windBearing"
        static let cloudCover = "cloudCover"
        static let uvIndex = "uvIndex"
        static let uvIndexTime = "uvIndexTime"
        static let visibility = "visibility"
        static let ozone = "ozone"
       
    }
    
    init(dailyWeatherDictionary: [String: Any]) {
        
        time = dailyWeatherDictionary[DailyWeatherKeys.time] as? Double
        summary = dailyWeatherDictionary[DailyWeatherKeys.summary] as? String
        icon = dailyWeatherDictionary[DailyWeatherKeys.icon] as? String
        sunriseTime = dailyWeatherDictionary[DailyWeatherKeys.sunriseTime] as? Double
        sunsetTime = dailyWeatherDictionary[DailyWeatherKeys.sunsetTime] as? Double
        moonPhase = dailyWeatherDictionary[DailyWeatherKeys.moonPhase] as? Double
        
        precipIntensity = dailyWeatherDictionary[DailyWeatherKeys.precipIntensity] as? Double
        precipIntensityMax = dailyWeatherDictionary[DailyWeatherKeys.precipIntensityMax] as? Double
        precipIntensityMaxTime = dailyWeatherDictionary[DailyWeatherKeys.precipIntensityMaxTime] as? Int
        precipProbability = dailyWeatherDictionary[DailyWeatherKeys.precipProbability] as? Double
        precipType = dailyWeatherDictionary[DailyWeatherKeys.precipType] as? String

        temperatureHigh = dailyWeatherDictionary[DailyWeatherKeys.temperatureHigh] as? Double
        temperatureHighTime = dailyWeatherDictionary[DailyWeatherKeys.temperatureHighTime] as? Int
        temperatureLow = dailyWeatherDictionary[DailyWeatherKeys.temperatureLow] as? Double
        temperatureLowTime = dailyWeatherDictionary[DailyWeatherKeys.temperatureLowTime] as? Int
        apparentTemperatureHigh = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureHigh] as? Double
        apparentTemperatureHighTime = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureHighTime] as? Int
        apparentTemperatureLow = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureLow] as? Double
        apparentTemperatureLowTime = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureLowTime] as? Int

        temperatureMin = dailyWeatherDictionary[DailyWeatherKeys.temperatureMin] as? Double
        temperatureMinTime = dailyWeatherDictionary[DailyWeatherKeys.temperatureMinTime] as? Int
        temperatureMax = dailyWeatherDictionary[DailyWeatherKeys.temperatureMax] as? Double
        temperatureMaxTime = dailyWeatherDictionary[DailyWeatherKeys.temperatureMaxTime] as? Int
        apparentTemperatureMin = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureMin] as? Double
        apparentTemperatureMinTime = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureMinTime] as? Int
        apparentTemperatureMax = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureMax] as? Double
        apparentTemperatureMaxTime = dailyWeatherDictionary[DailyWeatherKeys.apparentTemperatureMaxTime] as? Int

        dewPoint = dailyWeatherDictionary[DailyWeatherKeys.dewPoint] as? Double
        humidity = dailyWeatherDictionary[DailyWeatherKeys.humidity] as? Double
        pressure = dailyWeatherDictionary[DailyWeatherKeys.pressure] as? Double
        windSpeed = dailyWeatherDictionary[DailyWeatherKeys.windSpeed] as? Double
        windGust = dailyWeatherDictionary[DailyWeatherKeys.windGust] as? Double
        windGustTime = dailyWeatherDictionary[DailyWeatherKeys.windGustTime] as? Int
        windBearing = dailyWeatherDictionary[DailyWeatherKeys.windBearing] as? Int
        cloudCover = dailyWeatherDictionary[DailyWeatherKeys.cloudCover] as? Double
        uvIndex = dailyWeatherDictionary[DailyWeatherKeys.uvIndex] as? Int
        uvIndexTime = dailyWeatherDictionary[DailyWeatherKeys.uvIndexTime] as? Int
        visibility = dailyWeatherDictionary[DailyWeatherKeys.visibility] as? Int
        ozone = dailyWeatherDictionary[DailyWeatherKeys.ozone] as? Double

    }
}

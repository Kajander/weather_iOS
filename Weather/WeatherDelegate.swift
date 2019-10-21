//
//  WeatherDelegate.swift
//  Weather
//
//  Created by Joakim Kajan on 20.10.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import Foundation

protocol CurrentWeatherDelegate {
    func getCurrentWeather(apiKey: String)
}

//protocol HourlyWeatherDelegate {
//    <#requirements#>
//}

//protocol DailyWeatherDelegate {
//    <#requirements#>
//}


class WeatherDelegate {
    
    var currentWDelegate: CurrentWeatherDelegate!
//    var hourlyWDelegate: HourlyWeatherDelegate!
//    var dailyWDelegate: DailyWeatherDelegate!
    
    
    
    
}


//
//  ForecastService.swift
//  Weather
//
//  Created by Joakim Kajan on 28.02.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import Foundation

class ForecastService {
    
    let forecastAPIKey: String
    
    let forecastBaseURL: URL?
    
    init(APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    
    func getForecast(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?, HourlyWeather?, DailyWeather?) -> Void) {
        
        if let forecastURL = URL(string: "\(forecastBaseURL!)/\(latitude),\(longitude)") {
            
            let networkProsessor = NetworkProcessor(url: forecastURL)
            networkProsessor.downloadJSONFromUrl(_completion: { (jsonDictionary) in
                
                var currentWeather = CurrentWeather(currentWeatherDictionary: ["" : ""])
                var hourlyWeather = HourlyWeather(hourlyWeatherDictionary: ["" : ""])
                var dailyWeather = DailyWeather(dailyWeatherDictionary: ["" : ""])
                
                if let currentDataDictionary = jsonDictionary?["currently"] as? [String : Any] {
                    currentWeather = CurrentWeather(currentWeatherDictionary: currentDataDictionary)
                    completion(currentWeather, hourlyWeather, dailyWeather)
                }
                
                
                if var hourlyWeatherDictionary = jsonDictionary?["hourly"] as? [String : Any] {
                    let hourlyData = hourlyWeatherDictionary["data"] as! [[String : AnyObject]]
                    var tempDictionary = [String : Any]()
                    for obj in hourlyData {
                        
                        for (key,value) in obj {
                            
                            if let valueString = value as? String {
                                tempDictionary.updateValue(valueString, forKey: key)
                            } else if let valueDouble = value as? Double {
                                tempDictionary.updateValue(valueDouble, forKey: key)
                            } else if let valueInt = value as? Int {
                                tempDictionary.updateValue(valueInt, forKey: key)
                            } else {
                                print("Error converting AnyObject", value) // Was not a string
                                
                            }
                        }
                        hourlyWeatherDictionary = tempDictionary
                        hourlyWeather = HourlyWeather(hourlyWeatherDictionary: hourlyWeatherDictionary)
                        completion(currentWeather, hourlyWeather, dailyWeather)
                    }
                }
                
                
                if var dailyWeatherDictionary = jsonDictionary?["daily"] as? [String : Any] {
                    let dailyData = dailyWeatherDictionary["data"] as! [[String : AnyObject]]
                    var tempDictionary = [String : Any]()
                    for obj in dailyData {
                        
                        for (key,value) in obj {
                            
                            if let valueString = value as? String {
                                tempDictionary.updateValue(valueString, forKey: key)
                            } else if let valueDouble = value as? Double {
                                tempDictionary.updateValue(valueDouble, forKey: key)
                            } else if let valueInt = value as? Int {
                                tempDictionary.updateValue(valueInt, forKey: key)
                            } else {
                                print("Error converting AnyObject", value) // Was not a string
                                
                            }
                        }
                        dailyWeatherDictionary = tempDictionary
                        dailyWeather = DailyWeather(dailyWeatherDictionary: dailyWeatherDictionary)
                        completion(currentWeather, hourlyWeather, dailyWeather)
                        
                    }
                }
            })
        }
    }
}


// Write this class so it uses only one method for the required information.

//
//  SetupGradientLayer.swift
//  Weather
//
//  Created by Joakim Kajan on 01.04.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class HourlyGradientLayer {
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()

    var gradientLayer = CAGradientLayer()
    let date = Date()

    let dayColor = UIColor(red:0.00, green:0.60, blue:0.46, alpha:1.0).cgColor
    let nightColor = UIColor(red:0.27, green:0.30, blue:0.40, alpha:1.0).cgColor
    
    var firstEndLocation = NSNumber()
    var secondEndLocation = NSNumber()
    var thirdEndLocation = NSNumber()
    
    func gradientSetup(sunriseList: [Date], sunsetList: [Date], timeList: [Date]) -> [Double] {
        
        dateFormatter.dateFormat = "HH:mm Z"
        timeFormatter.dateFormat = "HH"
        
        let todaySunrise = sunriseList[0]
        let todaySunset = sunsetList[0]
        let tomorrowSunrise = sunriseList[1]
        
        var stringSunriseList = [String]()
        var stringSunsetList = [String]()
        
        var newTimeList = [String]()

        
        // Put new time values to lists (timeformatter)
        for time in timeList {
            let newTime = timeFormatter.string(from: time)
            newTimeList.append(newTime)
        }
        
        for sunrise in sunriseList {
            let newTime = timeFormatter.string(from: sunrise)
            stringSunriseList.append(newTime)
        }
        for sunset in sunsetList {
            let newTime = timeFormatter.string(from: sunset)
            stringSunsetList.append(newTime)
        }
        
        let colorLocations = self.setupColorLocations(timeList: timeList, stringSunriseList: stringSunriseList, stringSunsetList: stringSunsetList, todaySunrise: todaySunrise, todaySunset: todaySunset, tomorrowSunrise: tomorrowSunrise, newTimeList: newTimeList)
        
        return colorLocations
        
    }
    
    
    func setupColorLocations(timeList: [Date], stringSunriseList: [String], stringSunsetList: [String],
                             todaySunrise: Date, todaySunset: Date, tomorrowSunrise: Date, newTimeList: [String]) -> [Double] {
        
        let defaultNS = NSNumber(1.0)
        firstEndLocation = defaultNS
        secondEndLocation = defaultNS
        thirdEndLocation = defaultNS
        
        var colorLocations = [Double]()

        
        // If todays sunrise is behind and its day. Nextup is coming todaySunset and after that tomorrowSunrise
        // Example. current time is between todaySunrise(05.00-07.00) - todaySunset (20.00-23.00)
        if todaySunrise < date && todaySunset > date {
            //print("TodaySunrise is gone and todaySunset is coming. After that tomorrowSunrise")
            
            for sunset in stringSunsetList {
                
                if let sunsetIndex = newTimeList.firstIndex(of: sunset) {
                    let pos = Double(sunsetIndex) / Double(timeList.count)
                    let firstNSLocation = NSNumber(value: pos - 0.1)
                    firstEndLocation = firstNSLocation
                }else{
                    //print("Error - failed setting firstEndLocation for weatherGradient")
                }
                
                for tomorrowSunrise in stringSunriseList {
                    if let tomorrowSunRiseIndex = newTimeList.lastIndex(of: tomorrowSunrise) {
                        let pos = Double(tomorrowSunRiseIndex) / Double(timeList.count)
                        let secondNSLocation = NSNumber(value: pos - 0.1)
                        secondEndLocation = secondNSLocation
                    }else{
                        //print("Error - failed setting secondEndLocation for weatherGradient")
                    }
                }
            }
        }
        
        if todaySunset < date && tomorrowSunrise > date {
            //print("TodaySunset is gone and tomorrowsunrise is coming")
            
            for tomorrowSunrise in stringSunriseList {
                if let tomorrowSunriseIndex = newTimeList.lastIndex(of: tomorrowSunrise) {
                    let pos = Double(tomorrowSunriseIndex) / Double(timeList.count)
                    let nsFirstLocation = NSNumber(value: pos - 0.1)
                    firstEndLocation = nsFirstLocation
                }
            }
            for tomorrowSunset in stringSunsetList {
                if let tomorrowSunsetIndex = newTimeList.lastIndex(of: tomorrowSunset) {
                    let pos = Double(tomorrowSunsetIndex) / Double(timeList.count)
                    let nsSecondLocation = NSNumber(value: pos - 0.1)
                    secondEndLocation = nsSecondLocation
                }
            }
        }
        
        if todaySunrise > date {
            //print("Its over midnight")

            for todaySunRise in stringSunriseList {
                if let todaySunriseIndex = newTimeList.lastIndex(of: todaySunRise) {
                    let pos = Double(todaySunriseIndex) / Double(timeList.count)
                    let nsFirstLocation = NSNumber(value: pos - 0.1)
                    firstEndLocation = nsFirstLocation
                }
            }
            for todaySunset in stringSunsetList {
                if let todaySunsetIndex = newTimeList.lastIndex(of: todaySunset) {
                    let pos = Double(todaySunsetIndex) / Double(timeList.count)
                    let nsSecondLocation = NSNumber(value: pos - 0.1)
                    secondEndLocation = nsSecondLocation
                }
            }
        }
        
        colorLocations.append(Double(truncating: firstEndLocation))
        colorLocations.append(Double(truncating: secondEndLocation))
        colorLocations.append(Double(truncating: thirdEndLocation))
        
//        print("first",firstEndLocation)
//        print("second",secondEndLocation)
//        print("third",thirdEndLocation)
        
        return colorLocations
    }
    
    // MARK: - Setup color order
    func setupColor(todaySunrise: Date, todaySunset: Date, tomorrowSunrise: Date) -> [CGColor] {
        
        var colorArray = [CGColor]()
        
        // If todays sunrise is behind and its day. Nextup is coming todaySunset and after that tomorrowSunrise
        // Example. current time is between todaySunrise(05.00-07.00) - todaySunset (20.00-23.00)
        if todaySunrise < date && todaySunset > date {
            //print("TodaySunrise is gone and todaySunset is coming. After that tomorrowSunrise")
            colorArray.append(dayColor)
            colorArray.append(nightColor)
            colorArray.append(dayColor)
            
        }
        
        if todaySunset < date && tomorrowSunrise > date {
            //print("TodaySunset is gone and tomorrowsunrise is coming")
            colorArray.append(nightColor)
            colorArray.append(dayColor)
            colorArray.append(nightColor)
            
        }
        
        if todaySunrise > date {
            //print("Its over midnight")
            colorArray.append(nightColor)
            colorArray.append(dayColor)
            colorArray.append(nightColor)
            
        }
        
        //print("Color array: ",colorArray)
        
        return colorArray
 
    }
}

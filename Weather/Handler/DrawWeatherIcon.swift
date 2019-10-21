//
//  WeatherDraw.swift
//  Weather
//
//  Created by Joakim Kajan on 30.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class DrawWeatherIcon {
    
    let sun = Sun()
    let moon = Moon()
    let cloud = Cloud()
    let rain = Rain()
    let wind = Wind()
    let cloudAndSun = CloudAndSun()
    let cloudAndMoon = CloudAndMoon()
    
    let weatherIconShapeLayer = CAShapeLayer()
    
    func drawIcon(icon: String) -> CAShapeLayer {
        

        let iconRect = CGRect(x: 0, y: 0, width: 0, height: 0)

        
        switch icon {
            
        case let icon where icon == "clear-day":
            
            let sunShapeLayer = sun.drawSun()
            weatherIconShapeLayer.addSublayer(sunShapeLayer)

        case let icon where icon == "clear-night":
            
            let moonShapeLayer = moon.drawFullMoon(iconRect)
            let moonGlowShapeLayer = moon.drawFullMoonGlow(iconRect)
            weatherIconShapeLayer.addSublayer(moonShapeLayer)
            weatherIconShapeLayer.addSublayer(moonGlowShapeLayer)
            
        case let icon where icon == "rain":
            
            let cloudShapeLayer = rain.drawCloud(iconRect)
            let lightRainShapeLayer = rain.drawLightRain(iconRect)
            weatherIconShapeLayer.addSublayer(cloudShapeLayer)
            weatherIconShapeLayer.addSublayer(lightRainShapeLayer)
            
            
        case let icon where icon == "snow":
            print("Draw snow")
            
        
        case let icon where icon == "sleet":
            print("Draw sleet")
            
        case let icon where icon == "wind":
            print("Draw wind")
            
    
        case let icon where icon == "fog":
            print("Draw fog")
            
        case let icon where icon == "cloudy":

            let frontCloudShapeLayer = cloud.drawFrontCloud(iconRect)
            let backCloudShapeLayer = cloud.drawBackCloud(iconRect)
            weatherIconShapeLayer.addSublayer(backCloudShapeLayer)
            weatherIconShapeLayer.addSublayer(frontCloudShapeLayer)
            
        case let icon where icon == "partly-cloudy-day":

            let cloudShapeLayer = cloudAndSun.drawCloud(iconRect)
            let sunShapeLayer = cloudAndSun.drawSun(iconRect)
            let sunStripeLayer = cloudAndSun.drawSunGlow(iconRect)
            weatherIconShapeLayer.addSublayer(sunShapeLayer)
            weatherIconShapeLayer.addSublayer(sunStripeLayer)
            weatherIconShapeLayer.addSublayer(cloudShapeLayer)
            
        case let icon where icon == "partly-cloudy-night":
            
            let cloudShapeLayer = cloudAndMoon.drawCloud(iconRect)
            let moonShapeLayer = cloudAndMoon.drawMoon(iconRect)
            let moonGlowShapeLayer = cloudAndMoon.drawMoonStripe(iconRect)
            weatherIconShapeLayer.addSublayer(moonGlowShapeLayer)
            weatherIconShapeLayer.addSublayer(moonShapeLayer)
            weatherIconShapeLayer.addSublayer(cloudShapeLayer)
            
        default:
            print("Draw nothing")
        }
        
        return weatherIconShapeLayer
    }
}

//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Joakim Kajan on 01.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class SceneView: UIView {
    
    let largeSun = LargeSun()
    let largeMoon = LargeMoon()
    
    let temperatureLabel = UILabel()
    let summaryLabel = UILabel()
    let locationLabel = UILabel()
    let backroundView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    func setupView() {
        
        
    }
    
    func setupLocationLabel(city: String, country: String) {
        
        locationLabel.font = UIFont(name: "SFCompactText-Bold", size: 20)
        locationLabel.text = "\(city), \(country)"
        locationLabel.textAlignment = .center
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationLabel)
        
        locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
    }
    
    func setupTempLabel(temp: String) {
        
        // Do the fahrenheit stuff here too
        temperatureLabel.font = UIFont(name: "SFCompactText-Bold", size: 40)
        temperatureLabel.text = "\(temp) °C"
        temperatureLabel.textAlignment = .center
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(temperatureLabel)
        
        temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
    }
    
    func setupSummaryLabel(summaryString: String) {
        
        summaryLabel.text = summaryString
        summaryLabel.font = UIFont(name: "SFCompactText-Bold", size: 14)
        summaryLabel.textAlignment = .center
        
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(summaryLabel)
        
        summaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 2).isActive = true
    }
    
    
    //MARK: - Get Constant
    func getConstant(sunriseList: [Date], sunsetList: [Date], timeList: [Date], width: CGFloat) -> (constant: Int, defaultFirstSunConstant: Int, defaultFirstMoonConstant: Int) {
        
        
        var constant = 0
        var defaultFirstSunConstant = 0
        var defaultFirstMoonConstant = 0
        
        //TODO: - Figure these out when expanding to 24h version
//        var defaultSecondSunConstant = 0
//        var defaultSecondMoonConstant = 0
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm Z"
        timeFormatter.dateFormat = "HH"
        
        let date = Date()
        
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

        
        // Between sunrise and sunset
        if todaySunrise < date && todaySunset > date {
            
            let sunriseToNow = Calendar.current.dateComponents([.hour, .minute], from: todaySunrise, to: date)
            let sunriseHour = sunriseToNow.hour!
            let nowToSunset = Calendar.current.dateComponents([.hour, .minute], from: date, to: todaySunset)
            let sunsetHour = nowToSunset.hour!

            let sum = sunsetHour + sunriseHour
            constant = Int(width) / sum
            defaultFirstSunConstant = sunriseHour * constant
            defaultFirstMoonConstant = sunsetHour * -constant - constant
            
        }
        
        // Between sunset and tomorrow sunrise
        if todaySunset < date && tomorrowSunrise > date {

            let sunsetToNow = Calendar.current.dateComponents([.hour, .minute], from: todaySunset, to: date)
            let sunsetHour = sunsetToNow.hour!
            let nowToSunrise = Calendar.current.dateComponents([.hour, .minute], from: date, to: tomorrowSunrise)
            let sunriseHour = nowToSunrise.hour!
            
            let sum = sunsetHour + sunriseHour
            constant = Int(width) / sum

            defaultFirstMoonConstant = constant * sunsetHour
            defaultFirstSunConstant = sunriseHour * -constant
        }
        
        
        if todaySunrise > date {
            
            let sunsetToNow = Calendar.current.dateComponents([.hour, .minute], from: todaySunset, to: date)
            let sunsetHour = sunsetToNow.hour!
            let nowToSunrise = Calendar.current.dateComponents([.hour, .minute], from: date, to: tomorrowSunrise)
            let sunriseHour = nowToSunrise.hour!

            let sum = sunsetHour + sunriseHour
            
            constant = Int(width) / sum
            
        }
        
        return (constant, defaultFirstSunConstant, defaultFirstMoonConstant)
    
    }
    
    //MARK: SetupSun
    func setupSun() -> CAShapeLayer {
        
        let iconRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let sunLayer = largeSun.drawSun(iconRect)
        
        return sunLayer
    }
    
    //MARK: SetupMoon
    func setupMoon() -> CAShapeLayer {
        
        let iconRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let moonLayer = largeMoon.drawMoon(iconRect)
        
        return moonLayer
    }
    
    
    //MARK: Override Draw
    override func draw(_ rect: CGRect) {
        
        let p1 = bounds.origin
        let p2 = CGPoint(x: bounds.maxX, y: bounds.minY)
        let p3 = CGPoint(x: bounds.maxX, y: bounds.height)
        let p4 = CGPoint(x:p1.x, y: bounds.height)
        
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)

        path.close()
        
        let darkGreen = DarkGreen()
        darkGreen.draw(rect)
    }
    
    
    //MARK: Draw the scene
    //TODO: Move this to another file
    func drawBackground(_ rect: CGRect) {
        
        // First vuori
        let path4 = UIBezierPath()
        path4.move(to: CGPoint(x: bounds.minX, y: bounds.height / 5))
        path4.addCurve(to: CGPoint(x: bounds.width / 2, y: bounds.height / 5 * 3), controlPoint1: CGPoint(x: bounds.minX + 50, y: 100), controlPoint2: CGPoint(x: bounds.width / 5, y: 300))
        path4.addLine(to: CGPoint(x: bounds.minX, y: bounds.height / 5 * 3))
        path4.close()
        UIColor(red:0.02, green:0.18, blue:0.16, alpha:1.0).set()
        path4.fill()
        
        // Water
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: bounds.minX, y: bounds.height / 5 * 3))
        path3.addLine(to: CGPoint(x: bounds.maxX, y: bounds.height / 5 * 3))
        path3.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path3.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path3.close()
        UIColor(red:0.07, green:0.54, blue:0.48, alpha:1.0).set()
        path3.fill()
        
        // Back kumpu
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: bounds.minX, y: bounds.maxY - 150))
        path2.addQuadCurve(to: CGPoint(x: bounds.maxX, y: bounds.maxY - 50), controlPoint: CGPoint(x: bounds.width / 2, y: bounds.maxY - 100))
        path2.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path2.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path2.close()
        UIColor(red:0.04, green:0.30, blue:0.27, alpha:1.0).set()
        path2.fill()
        
        // Front kumpu
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: bounds.maxX, y: bounds.maxY - 150))
        path1.addQuadCurve(to: CGPoint(x: bounds.minX, y: bounds.maxY - 100), controlPoint: CGPoint(x: bounds.width / 2, y: bounds.maxY - 150))
        path1.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path1.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path1.close()
        UIColor(red:0.03, green:0.24, blue:0.21, alpha:1.0).set()
        path1.fill()
        
    }

}

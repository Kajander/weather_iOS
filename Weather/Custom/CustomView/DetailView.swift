//
//  DetailView.swift
//  Weather
//
//  Created by Joakim Kajan on 20.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit
import MapKit


class DetailView: UIView {

    let reverseLocation = ReverseLocation()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //MARK: SetupView
    //TODO: When dailyView has been created, use shadows or something to seperate these views visually
    func setupView(location: CLLocation, dailyIconList: [String], dailyMinTemp: [String], dailyMaxTemp: [String]) {
        
        backgroundColor = .clear

        setupLocationLabel(location: location)
        var constant = 120

        for i in 1...7 {
            
            let weekdayView = UIView()
            
            setupWeekdayLabel(i: i, weekdayView: weekdayView)
            setupMinAndMaxTempLabel(dailyMinTemp: dailyMinTemp[i], dailyMaxTemp: dailyMaxTemp[i], view: weekdayView)
            setupWeatherIcon(icon: dailyIconList[i], view: weekdayView)
            
            
//            weekdayView.layer.backgroundColor = UIColor.white.cgColor
//            weekdayView.layer.shadowColor = UIColor.gray.cgColor
//            weekdayView.layer.shadowRadius = 2
//            weekdayView.layer.shadowOffset = CGSize(width: 0, height: 1)
//            weekdayView.layer.shadowOpacity = 0.5
            
            weekdayView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(weekdayView)
            
            weekdayView.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(constant)).isActive = true
            weekdayView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            weekdayView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            
            constant = constant + 70
            
        }
    }
    
  
    //MARK: LocationLabel
    func setupLocationLabel(location: CLLocation) {
        
        let locLabel = UILabel()
        
        locLabel.font = UIFont(name: "ArialRoundedMTBold" ,size: 22)
        locLabel.textColor = UIColor(red:0.03, green:0.24, blue:0.21, alpha:1.0)
        
        locLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locLabel)
        locLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        locLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        locLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        reverseLocation.getPlace(location: location, label: locLabel)
        
    }
    
    
    //MARK: WeekdayLabel
    func setupWeekdayLabel(i: Int, weekdayView: UIView) {
        let today = Date()
        let date = Calendar.current.date(byAdding: .day, value: i, to: today) ?? today
        let weekday = Calendar.current.component(.weekday, from: date)

        let weekdayLabel = UILabel()
        weekdayLabel.font = UIFont(name: "ArialRoundedMTBold" ,size: 18)
        
        switch weekday {
        case 1:
            weekdayLabel.text = "Sunday"
        case 2:
        weekdayLabel.text = "Monday"
        case 3:
        weekdayLabel.text = "Tuesday"
        case 4:
        weekdayLabel.text = "Wednesday"
        case 5:
        weekdayLabel.text = "Thursday"
        case 6:
        weekdayLabel.text = "Friday"
        case 7:
        weekdayLabel.text = "Saturday"
        default:
            weekdayLabel.text = "Problems"
        }
        
        weekdayLabel.textColor = UIColor(red:0.05, green:0.36, blue:0.32, alpha:1.0)
        
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        weekdayView.addSubview(weekdayLabel)
        
        weekdayLabel.topAnchor.constraint(equalTo: weekdayView.topAnchor).isActive = true
        weekdayLabel.leadingAnchor.constraint(equalTo: weekdayView.leadingAnchor, constant: 20).isActive = true
        
    }
    
    //MARK: MinAndMaxTempLabel
    func setupMinAndMaxTempLabel(dailyMinTemp: String, dailyMaxTemp: String, view: UIView) {
        
        let minMaxLabel = UILabel()
        minMaxLabel.font = UIFont(name: "ArialRoundedMTBold" ,size: 18)
        minMaxLabel.numberOfLines = 3
        minMaxLabel.text = "↑ \(dailyMaxTemp)°\n↓ \(dailyMinTemp)°"
        minMaxLabel.textColor = UIColor(red:0.05, green:0.36, blue:0.32, alpha:1.0)
        
        minMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(minMaxLabel)
        
        minMaxLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        minMaxLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        minMaxLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    //MARK: Icon
    //TODO: Animations wont work. Why??
    func setupWeatherIcon(icon: String, view: UIView) {
        let drawWeatherIcon = DrawWeatherIcon()

        let iconView = UIView()
        let iconShapeLayer = drawWeatherIcon.drawIcon(icon: icon)

        iconView.layer.addSublayer(iconShapeLayer)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconView)
  
        
        iconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200).isActive = true
        iconView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -150).isActive = true
        iconView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    override func draw(_ rect: CGRect) {
        let size = self.bounds.size
        
        let p1 = CGPoint(x: bounds.minX, y: bounds.minY)
        let p2 = CGPoint(x:p1.x + size.width, y: bounds.minY + 50)
        let p3 = CGPoint(x:p2.x, y: bounds.height)
        let p4 = CGPoint(x:size.width/2, y:size.height)
        let p5 = CGPoint(x:p1.x, y: bounds.height)
        
        // create the path
        let path = UIBezierPath()
        path.move(to: p1)
        path.addCurve(to: p2, controlPoint1: CGPoint(x: bounds.width / 2, y: bounds.minX + 50 ), controlPoint2: CGPoint(x: bounds.width / 2, y: bounds.minY - 30))
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.close()
        
        
        // fill the path
        UIColor.white.set()
        path.fill()
    }

}

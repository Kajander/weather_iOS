//
//  WeatherView.swift
//  Weather
//
//  Created by Joakim Kajan on 30.08.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class SimpleWeatherView: UIView {
    
    let drawWeatherIcon = DrawWeatherIcon()
    let temperatureLabel = UILabel()
    let locLabel = UILabel()
    let iconView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    func setupView() {
        
        setShadow()
        backgroundColor = .clear
    }
    
    //MARK: Shadow
    // Not in use atm
    func setShadow() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 4

   
    }
    
    //MARK: TemperatureLabel
    //TODO: - Hadle Fahrenheit stuff somewhere
    func setupTempLabel(temp: String) {
        temperatureLabel.frame = CGRect(x: 30, y: 30, width: 80, height: 30)
        temperatureLabel.font = UIFont (name: "SFCompactText-Bold", size: 20)
        temperatureLabel.textColor = UIColor.white
        temperatureLabel.text = "\(temp) °C"
        addSubview(temperatureLabel)
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        temperatureLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
    }
    
    //MARK: LocationLabel
    func setupLocLabel(loc: String) {
        
        locLabel.frame = CGRect(x: 110, y: 30, width: 160, height: 30)
        locLabel.font = UIFont (name: "SFCompactText-Bold", size: 20)
        locLabel.textColor = UIColor.white
        locLabel.text = loc.uppercased()
        addSubview(locLabel)
        
        locLabel.translatesAutoresizingMaskIntoConstraints = false
        locLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        locLabel.leftAnchor.constraint(equalTo: temperatureLabel.rightAnchor, constant: 10).isActive = true
        
    }
    
    //MARK: Icon
    func setupIcon(icon: String) {
        let iconShapeLayer = drawWeatherIcon.drawIcon(icon: icon)

        iconView.layer.addSublayer(iconShapeLayer)

        
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        iconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true

        
    }
    
    //MARK: Override Draw
    override func draw(_ rect: CGRect) {

        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        UIColor(red:0.42, green:0.86, blue:0.55, alpha:1.0).setFill()
        roundedRect.fill()
        
//        let darkGreen = DarkGreen()
//        darkGreen.draw(rect)

    }
    
}

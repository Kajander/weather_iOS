//
//  Rain.swift
//  Weather
//
//  Created by Joakim Kajan on 31.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class Rain {
    
    let cloudShapeLayer = CAShapeLayer()
    let cloudMutablePath = CGMutablePath()
    let lightRainShapeLayer = CAShapeLayer()
    let lightRainMutablePath = CGMutablePath()
    

    func drawCloud(_ rect: CGRect) -> CAShapeLayer {
        
        let cloudX = rect.origin.x
        let cloudY = rect.origin.y
        
        let cloud_1Center_1 = CGPoint(x: cloudX - 10, y: cloudY)
        let cloud_1Radius_1: CGFloat = 10
        
        let cloud_1Center_2 = CGPoint(x: cloudX, y: cloudY - 10)
        let cloud_1Radius_2: CGFloat = 10
        
        let cloud_1Center_3 = CGPoint(x: cloudX + 15, y: cloudY - 5)
        let cloud_1Radius_3: CGFloat = 15
        
        let cloud_1Center_4 = CGPoint(x: cloudX + 30, y: cloudY)
        let cloud_1Radius_4: CGFloat = 10
        
        let moveTo = CGPoint(x: cloudX - 10, y: cloudY + 10)
        
        cloudMutablePath.move(to: moveTo)
        cloudMutablePath.addArc(center: cloud_1Center_1, radius: cloud_1Radius_1, startAngle: CGFloat(Double.pi / 2), endAngle:CGFloat(Double.pi * 3 / 2), clockwise: false)
        
        cloudMutablePath.addArc(center: cloud_1Center_2, radius: cloud_1Radius_2, startAngle: CGFloat(Double.pi), endAngle:CGFloat(Double.pi * 7 / 4), clockwise: false)
        
        cloudMutablePath.addArc(center: cloud_1Center_3, radius: cloud_1Radius_3, startAngle: CGFloat(Double.pi * 4 / 3), endAngle:CGFloat(Double.pi * 11 / 6), clockwise: false)
        
        cloudMutablePath.addArc(center: cloud_1Center_4, radius: cloud_1Radius_4, startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: false)
        cloudMutablePath.closeSubpath()
        
        cloudShapeLayer.path = cloudMutablePath
        cloudShapeLayer.lineWidth = 3
        cloudShapeLayer.strokeColor = UIColor(red:0.22, green:0.42, blue:0.54, alpha:1.0).cgColor
        cloudShapeLayer.fillColor = UIColor(red:0.51, green:0.65, blue:0.73, alpha:1.0).cgColor
        
        cloudShapeLayer.shadowColor = UIColor.black.cgColor
        cloudShapeLayer.shadowOpacity = 1
        cloudShapeLayer.shadowRadius = 5
        cloudShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        return cloudShapeLayer
       
    }
    
    func drawLightRain(_ rect: CGRect) -> CAShapeLayer {
     
        
        let rainX = rect.origin.x
        let rainY = rect.origin.y + 5
        let rainDrop_1Start = CGPoint(x: rainX - 10, y: rainY)
        let rainDrop_1End = CGPoint(x: rainX - 13, y: rainY + 10)
        lightRainMutablePath.move(to: rainDrop_1Start)
        lightRainMutablePath.addLine(to: rainDrop_1End)
        
        let rainDrop_2Start = CGPoint(x: rainX, y: rainY)
        let rainDrop_2End = CGPoint(x: rainX - 3, y: rainY + 10)
        lightRainMutablePath.move(to: rainDrop_2Start)
        lightRainMutablePath.addLine(to: rainDrop_2End)
        
        let rainDrop_3Start = CGPoint(x: rainX + 10, y: rainY)
        let rainDrop_3End = CGPoint(x: rainX + 7, y: rainY + 10)
        lightRainMutablePath.move(to: rainDrop_3Start)
        lightRainMutablePath.addLine(to: rainDrop_3End)
        
        let rainDrop_4Start = CGPoint(x: rainX + 20, y: rainY)
        let rainDrop_4End = CGPoint(x: rainX + 17, y: rainY + 10)
        lightRainMutablePath.move(to: rainDrop_4Start)
        lightRainMutablePath.addLine(to: rainDrop_4End)
        
        let rainDrop_5Start = CGPoint(x: rainX + 30, y: rainY)
        let rainDrop_5End = CGPoint(x: rainX + 27, y: rainY + 10)
        lightRainMutablePath.move(to: rainDrop_5Start)
        lightRainMutablePath.addLine(to: rainDrop_5End)
        
        lightRainShapeLayer.path = lightRainMutablePath
        lightRainShapeLayer.lineWidth = 2
        lightRainShapeLayer.strokeColor = UIColor(red:0.51, green:0.65, blue:0.73, alpha:1.0).cgColor
        lightRainShapeLayer.fillColor = UIColor(red:0.22, green:0.42, blue:0.54, alpha:1.0).cgColor
        
        lightRainShapeLayer.shadowColor = UIColor.black.cgColor
        lightRainShapeLayer.shadowOpacity = 1
        lightRainShapeLayer.shadowRadius = 2
        lightRainShapeLayer.shadowOffset = CGSize(width: 2, height: 2)
        
        animateLightRainPosition()
        animateLighRainOpacity()
        
        return lightRainShapeLayer
        
    }
    
    func animateLightRainPosition() {
        
        let lightRainAnimation = CABasicAnimation(keyPath: "position")
        lightRainAnimation.fromValue = [0, -2]
        lightRainAnimation.toValue = [-3, 10]
        lightRainAnimation.repeatCount = .infinity
        lightRainAnimation.autoreverses = false
        lightRainAnimation.duration = 1.5
        lightRainAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        lightRainAnimation.repeatCount = .greatestFiniteMagnitude
        
        lightRainShapeLayer.add(lightRainAnimation, forKey: "position")
        
    }
    
    func animateLighRainOpacity() {
        
        let lightRainOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        lightRainOpacityAnimation.fromValue = NSNumber(floatLiteral: 0.0)
        lightRainOpacityAnimation.toValue = NSNumber(floatLiteral: 1.0)
        lightRainOpacityAnimation.repeatCount = .infinity
        lightRainOpacityAnimation.autoreverses = true
        lightRainOpacityAnimation.duration = 0.75
        lightRainOpacityAnimation.repeatCount = .greatestFiniteMagnitude
        
        lightRainShapeLayer.add(lightRainOpacityAnimation, forKey: "opacity")
        
    }
}

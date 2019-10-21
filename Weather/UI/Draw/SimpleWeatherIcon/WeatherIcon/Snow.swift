//
//  Snow.swift
//  Weather
//
//  Created by Joakim Kajan on 31.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class Snow {
    
    let cloudShapeLayer = CAShapeLayer()
    let cloudMutablePath = CGMutablePath()
    let lightSnowShapeLayer = CAShapeLayer()
    let lightSnowMutablePath = CGMutablePath()

    
    //_ rect: CGRect, position: Int
    func drawCloud(_ rect: CGRect) -> CAShapeLayer {
        // Drawing code
        
        // COunt this stuff ouf properly
        // radius first and by that count location adders for center positions
        // Ex. center.x = center.x + radius / 2
        
//        let cloudX = rect.origin.x - CGFloat(10)
//        let cloudY = rect.origin.y + CGFloat(position)
        
        let cloudX = rect.origin.x
        let cloudY = rect.origin.y - CGFloat(150)
        
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
        cloudShapeLayer.strokeColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0).cgColor
        cloudShapeLayer.fillColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
        
        return cloudShapeLayer
        
    }
    
    
    func drawLightSnow(_ rect: CGRect) -> CAShapeLayer {
        
        let snowX = rect.origin.x
        let snowY = rect.origin.y - CGFloat(145)
        let snow1Center = CGPoint(x: snowX - 10, y: snowY) // Set sun out of way for the timebeing
        let snow1MoveTo = CGPoint(x: snowX - 10, y: snowY)
        let snow2Center = CGPoint(x: snowX, y: snowY) // Set sun out of way for the timebeing
        let snow2MoveTo = CGPoint(x: snowX, y: snowY)
        let snow3Center = CGPoint(x: snowX + 10, y: snowY) // Set sun out of way for the timebeing
        let snow3MoveTo = CGPoint(x: snowX + 10, y: snowY)
        let snow4Center = CGPoint(x: snowX + 20, y: snowY) // Set sun out of way for the timebeing
        let snow4MoveTo = CGPoint(x: snowX + 20, y: snowY)
        let snow5Center = CGPoint(x: snowX + 30, y: snowY) // Set sun out of way for the timebeing
        let snow5MoveTo = CGPoint(x: snowX + 30, y: snowY)
        
        lightSnowMutablePath.move(to: snow1MoveTo)
        lightSnowMutablePath.addArc(center: snow1Center, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        lightSnowMutablePath.move(to: snow2MoveTo)
        lightSnowMutablePath.addArc(center: snow2Center, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        lightSnowMutablePath.move(to: snow3MoveTo)
        lightSnowMutablePath.addArc(center: snow3Center, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        lightSnowMutablePath.move(to: snow4MoveTo)
        lightSnowMutablePath.addArc(center: snow4Center, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        lightSnowMutablePath.move(to: snow5MoveTo)
        lightSnowMutablePath.addArc(center: snow5Center, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        
        lightSnowShapeLayer.path = lightSnowMutablePath
        lightSnowShapeLayer.fillColor = UIColor.white.cgColor
        
        animateSnow()
        
        return lightSnowShapeLayer
        
    }
    
    func animateSnow() {
        
        let lightSnowAnimation = CABasicAnimation(keyPath: "position")
        lightSnowAnimation.fromValue = [0, 0]
        lightSnowAnimation.toValue = [0, 20]
        lightSnowAnimation.byValue = [-5 , 20]

        lightSnowAnimation.repeatCount = .infinity
        lightSnowAnimation.autoreverses = false
        lightSnowAnimation.duration = 1.5
        lightSnowAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        lightSnowAnimation.repeatCount = .greatestFiniteMagnitude
        
        lightSnowShapeLayer.add(lightSnowAnimation, forKey: "position")
    }
    
}

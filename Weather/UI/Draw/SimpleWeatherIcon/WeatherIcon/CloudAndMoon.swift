//
//  CloudAndMoon.swift
//  Weather
//
//  Created by Joakim Kajan on 30.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class CloudAndMoon {
    
    let cloudShapeLayer = CAShapeLayer()
    let cloudMutablePath = CGMutablePath()
    
    let fullMoonShapeLayer = CAShapeLayer()
    let fullMoonMutablePath = CGMutablePath()
    
    let fullMoonGlowShapeLayer = CAShapeLayer()
    let fullMoonGloWMutablePath = CGMutablePath()

    func drawCloud(_ rect: CGRect) -> CAShapeLayer  {
       
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
        
        cloudShapeLayer.shadowColor = UIColor.black.cgColor
        cloudShapeLayer.shadowOpacity = 1
        cloudShapeLayer.shadowRadius = 5
        cloudShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        cloudShapeLayer.lineWidth = 3
        cloudShapeLayer.strokeColor = UIColor(red:0.51, green:0.65, blue:0.73, alpha:1.0).cgColor
        cloudShapeLayer.fillColor = UIColor(red:0.87, green:0.91, blue:0.93, alpha:1.0).cgColor
        
        return cloudShapeLayer
    }
    
    func drawMoon(_ rect: CGRect) -> CAShapeLayer  {
        let moonX = rect.origin.x - 10 //Offset so that moon 'peeks'
        let moonY = rect.origin.y - 10
        let moonCenter = CGPoint(x: moonX, y: moonY)
        let moonMoveTo = CGPoint(x: moonX, y: moonY)
        
        fullMoonMutablePath.move(to: moonMoveTo)
        fullMoonMutablePath.addArc(center: moonCenter, radius: CGFloat(17), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        fullMoonMutablePath.closeSubpath()
        
        
        fullMoonShapeLayer.path = fullMoonMutablePath
        fullMoonShapeLayer.fillColor = UIColor(red:0.79, green:0.79, blue:0.79, alpha:1.0).cgColor
        
        return fullMoonShapeLayer
    }
    
     func drawMoonStripe(_ rect: CGRect) -> CAShapeLayer  {
     
        let stripeX = rect.origin.x - 10 //Offset so that moon 'peeks'
        let stripeY = rect.origin.y - 10
        let stripeCenter = CGPoint(x: stripeX, y: stripeY)
        let stripeMoveTo = CGPoint(x: stripeX, y: stripeY)
        
        fullMoonGloWMutablePath.move(to: stripeMoveTo)
        fullMoonGloWMutablePath.addArc(center: stripeCenter, radius: CGFloat(22), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        fullMoonGloWMutablePath.closeSubpath()
        
        fullMoonGlowShapeLayer.path = fullMoonGloWMutablePath
        fullMoonGlowShapeLayer.fillColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        
        fullMoonGlowShapeLayer.shadowColor = UIColor.black.cgColor
        fullMoonGlowShapeLayer.shadowOpacity = 1
        fullMoonGlowShapeLayer.shadowRadius = 5
        fullMoonGlowShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        animateMoonOpacity()
        
        return fullMoonGlowShapeLayer
        
    }
    
    func animateMoonOpacity() {
        // Animating outerStripe
        
        let moonOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        moonOpacityAnimation.fromValue = NSNumber(floatLiteral: 0.4)
        moonOpacityAnimation.toValue = NSNumber(floatLiteral: 0.7)
        moonOpacityAnimation.repeatCount = .infinity
        moonOpacityAnimation.autoreverses = true
        moonOpacityAnimation.duration = 1.2
        moonOpacityAnimation.repeatCount = .greatestFiniteMagnitude
        
        fullMoonGlowShapeLayer.add(moonOpacityAnimation, forKey: "opacity")
        
    }
    
    
    
}

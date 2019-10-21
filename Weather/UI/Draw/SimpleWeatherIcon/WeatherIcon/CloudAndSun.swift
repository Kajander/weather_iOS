//
//  CloudAndSun.swift
//  Weather
//
//  Created by Joakim Kajan on 30.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class CloudAndSun {
    
    let cloudShapeLayer = CAShapeLayer()

    let sunShapeLayer = CAShapeLayer()
    let sunGlowShapeLayer = CAShapeLayer()
    
    func drawCloud(_ rect: CGRect) -> CAShapeLayer  {
        
        let cloudX = rect.origin.x
        let cloudY = rect.origin.y
        let cloud1_Center = CGPoint(x: cloudX - 10, y: cloudY)
        let cloud1_Radius: CGFloat = 10
        
        let cloud2Center = CGPoint(x: cloudX, y: cloudY - 10)
        let cloud2Radius: CGFloat = 10
        
        let cloud3Center = CGPoint(x: cloudX + 15, y: cloudY - 5)
        let cloud3Radius: CGFloat = 15
        
        let cloud4Center = CGPoint(x: cloudX + 30, y: cloudY)
        let cloud4Radius: CGFloat = 10
        let moveTo = CGPoint(x: cloudX - 10, y: cloudY + 10)
        
        let cloudMutablePath = CGMutablePath()
        cloudMutablePath.move(to: moveTo)
        
        cloudMutablePath.addArc(center: cloud1_Center, radius: cloud1_Radius, startAngle: CGFloat(Double.pi / 2), endAngle:CGFloat(Double.pi * 3 / 2), clockwise: false)
        
        cloudMutablePath.addArc(center: cloud2Center, radius: cloud2Radius, startAngle: CGFloat(Double.pi), endAngle:CGFloat(Double.pi * 7 / 4), clockwise: false)
        
        cloudMutablePath.addArc(center: cloud3Center, radius: cloud3Radius, startAngle: CGFloat(Double.pi * 4 / 3), endAngle:CGFloat(Double.pi * 11 / 6), clockwise: false)
        
        cloudMutablePath.addArc(center: cloud4Center, radius: cloud4Radius, startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: false)
        cloudMutablePath.closeSubpath()
        
        cloudShapeLayer.path = cloudMutablePath
        
        cloudShapeLayer.shadowColor = UIColor.black.cgColor
        cloudShapeLayer.shadowOpacity = 1
        cloudShapeLayer.shadowRadius = 5
        cloudShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        cloudShapeLayer.lineWidth = 3
        cloudShapeLayer.strokeColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0).cgColor
        cloudShapeLayer.fillColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0).cgColor

        return cloudShapeLayer
    }
    
     func drawSun(_ rect: CGRect) -> CAShapeLayer {

        let sunX = rect.origin.x - 10 //Offset so that sun 'peeks'
        let sunY = rect.origin.y - 10
        let sunCenter = CGPoint(x: sunX, y: sunY)
        let sunMoveTo = CGPoint(x: sunX, y: sunY)
        
        let sunMutablePath = CGMutablePath()
        sunMutablePath.move(to: sunMoveTo)
        sunMutablePath.addArc(center: sunCenter, radius: CGFloat(17), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        sunMutablePath.closeSubpath()
        
        sunShapeLayer.path = sunMutablePath
        sunShapeLayer.fillColor = UIColor(red:1.00, green:0.76, blue:0.00, alpha:1.0).cgColor
        
        return sunShapeLayer
        
    }
    
    
    func drawSunGlow(_ rect: CGRect) -> CAShapeLayer {
        
        let glowX = rect.origin.x - 10 //Offset so that sun 'peeks'
        let glowY = rect.origin.y - 10
        let stripeCenter = CGPoint(x: glowX, y: glowY)
        let stripeMoveTo = CGPoint(x: glowX, y: glowY)

        let sunGlowMutablePath = CGMutablePath()
        sunGlowMutablePath.move(to: stripeMoveTo)
        sunGlowMutablePath.addArc(center: stripeCenter, radius: CGFloat(24), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        sunGlowMutablePath.closeSubpath()
        
        sunGlowShapeLayer.path = sunGlowMutablePath
        sunGlowShapeLayer.fillColor = UIColor(red:1.00, green:0.76, blue:0.00, alpha:1.0).cgColor
        
        sunGlowShapeLayer.shadowColor = UIColor.black.cgColor
        sunGlowShapeLayer.shadowOpacity = 1
        sunGlowShapeLayer.shadowRadius = 5
        sunGlowShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        animateSunOpacity()
        
        return sunGlowShapeLayer

    }
    
    

    
    func animateSunOpacity() {
        // Animating innerStripe
        
        let sunGlowOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        sunGlowOpacityAnimation.fromValue = NSNumber(floatLiteral: 0.4)
        sunGlowOpacityAnimation.toValue = NSNumber(floatLiteral: 0.7)
        sunGlowOpacityAnimation.repeatCount = .infinity
        sunGlowOpacityAnimation.autoreverses = true
        sunGlowOpacityAnimation.duration = 1.2
        
        sunGlowShapeLayer.add(sunGlowOpacityAnimation, forKey: "opacity")
        
    }
    
    
    
}

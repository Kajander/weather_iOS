//
//  Moon.swift
//  Weather
//
//  Created by Joakim Kajan on 30.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class Moon {
    // 0 corresponds to a new moon, 0.25 to a first quarter moon, 0.5 to a full moon, and 0.75 to a last quarter moon.
    
    let fullMoonShapeLayer = CAShapeLayer()
    let fullMoonGlowShapeLayer = CAShapeLayer()
    let newMoonShapeLayer = CAShapeLayer()
    let newMoonMutablePath = CGMutablePath()
    let firstQuarterMoonShapeLayer = CAShapeLayer()
    let firstQuarterMoonGlowShapeLayer = CAShapeLayer()
    let lastQuarterMoonShapeLayer = CAShapeLayer()
    let lastQuarterMoonGlowShapeLayer = CAShapeLayer()
    
    // MARK: - FullMoon
    func drawFullMoon(_ rect: CGRect) -> CAShapeLayer  {

        let fullMoonMutablePath = CGMutablePath()
        let moonX = rect.origin.x
        let moonY = rect.origin.y
        let moonCenter = CGPoint(x: moonX, y: moonY)
        
        let moonMoveTo = CGPoint(x: moonX, y: moonY)
        
        fullMoonMutablePath.move(to: moonMoveTo)
        fullMoonMutablePath.addArc(center: moonCenter, radius: CGFloat(21), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        fullMoonMutablePath.closeSubpath()

        
        fullMoonShapeLayer.path = fullMoonMutablePath
        fullMoonShapeLayer.fillColor = UIColor(red:0.79, green:0.79, blue:0.79, alpha:1.0).cgColor

        return fullMoonShapeLayer
    }
    
    func drawFullMoonGlow(_ rect: CGRect) -> CAShapeLayer {
        
        let fullMoonGlowMutablePath = CGMutablePath()
        let stripeX = rect.origin.x
        let stripeY = rect.origin.y
        let stripeCenter = CGPoint(x: stripeX, y: stripeY)
        let stripeMoveTo = CGPoint(x: stripeX, y: stripeY)
        
        fullMoonGlowMutablePath.move(to: stripeMoveTo)
        fullMoonGlowMutablePath.addArc(center: stripeCenter, radius: CGFloat(26), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        fullMoonGlowMutablePath.closeSubpath()
        
        fullMoonGlowShapeLayer.path = fullMoonGlowMutablePath
        fullMoonGlowShapeLayer.fillColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        
        fullMoonGlowShapeLayer.shadowColor = UIColor.black.cgColor
        fullMoonGlowShapeLayer.shadowOpacity = 1
        fullMoonGlowShapeLayer.shadowRadius = 5
        fullMoonGlowShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        animateMoonGlow()

        return fullMoonGlowShapeLayer
    }
    
    // MARK: - NewMoon
    func drawNewMoon(_ rect: CGRect) -> CAShapeLayer  {
 
        let moonX = rect.origin.x
        let moonY = rect.origin.y
        
        let moonCenter = CGPoint(x: moonX, y: moonY)
        let moonMoveTo = CGPoint(x: moonX, y: moonY)

        
        newMoonMutablePath.move(to: moonMoveTo)
        
        newMoonMutablePath.addArc(center: moonCenter, radius: CGFloat(22), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        newMoonMutablePath.closeSubpath()

    
        newMoonShapeLayer.lineWidth = 1
        newMoonShapeLayer.strokeColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        newMoonShapeLayer.path = newMoonMutablePath
        newMoonShapeLayer.fillColor = UIColor(red:0.33, green:0.41, blue:0.47, alpha:1.0).cgColor
        
        animateMoonGlow()
        return newMoonShapeLayer
    }

    // MARK: - FirsQuarterMoon
    func drawFirstQuarterMoon(_ rect: CGRect) -> CAShapeLayer  {

        let firstQuarterMoonMutablePath = CGMutablePath()
        let moonX = rect.origin.x
        let moonY = rect.origin.y
        
        let moonCenter = CGPoint(x: moonX, y: moonY)
        let moonMoveTo = CGPoint(x: moonX, y: moonY)
        
        firstQuarterMoonMutablePath.move(to: moonMoveTo)
        firstQuarterMoonMutablePath.addArc(center: moonCenter, radius: CGFloat(17), startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: false)
        firstQuarterMoonMutablePath.closeSubpath()
        
        
        firstQuarterMoonShapeLayer.path = firstQuarterMoonMutablePath
        firstQuarterMoonShapeLayer.fillColor = UIColor(red:0.79, green:0.79, blue:0.79, alpha:1.0).cgColor
        
        return firstQuarterMoonShapeLayer
    }
    
    func drawFirstQuarterMoonGlow(_ rect: CGRect) -> CAShapeLayer {
 
        let firstQuarterMoonGlowMutablePath = CGMutablePath()
        let stripeX = rect.origin.x
        let stripeY = rect.origin.y

        let stripeCenter = CGPoint(x: stripeX, y: stripeY)
        let stripeMoveTo = CGPoint(x: stripeX, y: stripeY)
        
        firstQuarterMoonGlowMutablePath.move(to: stripeMoveTo)
        firstQuarterMoonGlowMutablePath.addArc(center: stripeCenter, radius: CGFloat(22), startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: false)
        firstQuarterMoonGlowMutablePath.closeSubpath()
        
        firstQuarterMoonGlowShapeLayer.path = firstQuarterMoonGlowMutablePath
        firstQuarterMoonGlowShapeLayer.fillColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        
        animateMoonGlow()
        
        return firstQuarterMoonGlowShapeLayer
    }
    
    // MARK: - LastQuarterMoon
    func drawLastQuarterMoon(_ rect: CGRect) -> CAShapeLayer {
   
        let lastQuarterMoonMutablePath = CGMutablePath()
        let stripeX = rect.origin.x
        let stripeY = rect.origin.y
        
        let stripeCenter = CGPoint(x: stripeX, y: stripeY)
        let stripeMoveTo = CGPoint(x: stripeX, y: stripeY)
        
        lastQuarterMoonMutablePath.move(to: stripeMoveTo)
        lastQuarterMoonMutablePath.addArc(center: stripeCenter, radius: CGFloat(17), startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: true)
        lastQuarterMoonMutablePath.closeSubpath()
        
        lastQuarterMoonShapeLayer.path = lastQuarterMoonMutablePath
        lastQuarterMoonShapeLayer.fillColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        
        return lastQuarterMoonShapeLayer
    }
    
    func drawLastQuarterMoonGlow(_ rect: CGRect) -> CAShapeLayer {
   
        let lastQuarterMoonGlowMutablePath = CGMutablePath()
        let stripeX = rect.origin.x
        let stripeY = rect.origin.y
        
        let stripeCenter = CGPoint(x: stripeX, y: stripeY)
        let stripeMoveTo = CGPoint(x: stripeX, y: stripeY)
        
        lastQuarterMoonGlowMutablePath.move(to: stripeMoveTo)
        lastQuarterMoonGlowMutablePath.addArc(center: stripeCenter, radius: CGFloat(22), startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: true)
        lastQuarterMoonGlowMutablePath.closeSubpath()
        
        lastQuarterMoonGlowShapeLayer.path = lastQuarterMoonGlowMutablePath
        lastQuarterMoonGlowShapeLayer.fillColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        
        animateMoonGlow()
        
        return lastQuarterMoonGlowShapeLayer
    }
    
    // MARK: - Animations
    func animateMoonGlow() {
        
        let moonGlowAnimation = CABasicAnimation(keyPath: "opacity")
        moonGlowAnimation.fromValue = NSNumber(floatLiteral: 0.4)
        moonGlowAnimation.toValue = NSNumber(floatLiteral: 0.7)
        moonGlowAnimation.repeatCount = .infinity
        moonGlowAnimation.autoreverses = true
        moonGlowAnimation.duration = 1.2
        moonGlowAnimation.repeatCount = .greatestFiniteMagnitude
        
        fullMoonGlowShapeLayer.add(moonGlowAnimation, forKey: "opacity")
        firstQuarterMoonGlowShapeLayer.add(moonGlowAnimation, forKey: "opacity")
        lastQuarterMoonGlowShapeLayer.add(moonGlowAnimation, forKey: "opacity")
        
    }
    
    
}

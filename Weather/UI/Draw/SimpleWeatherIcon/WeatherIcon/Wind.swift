//
//  Wind.swift
//  Weather
//
//  Created by Joakim Kajan on 31.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class Wind {
    
    let windShapeLayer = CAShapeLayer()
    let windMutablePath = CGMutablePath()
    
    let wind1ShapeLayer = CAShapeLayer()
    let wind2ShapeLayer = CAShapeLayer()
    let wind3ShapeLayer = CAShapeLayer()
    
    
    func drawWind(_ rect: CGRect, position: Int) -> CAShapeLayer {
        
        let stripeX = rect.origin.x
        let stripeY = rect.origin.y
        
        // First Wind
        let windStripe_1Start = CGPoint(x: stripeX - 20, y: stripeY)
        let windStripe_1End = CGPoint(x: stripeX + 5, y: stripeY)
        windMutablePath.move(to: windStripe_1Start)
        windMutablePath.addLine(to: windStripe_1End)
        
        let wind1Path = UIBezierPath()
        wind1Path.move(to: windStripe_1Start)
        wind1Path.addLine(to: windStripe_1End)
        
        windMutablePath.closeSubpath()
        
        let wind1_center = CGPoint(x: stripeX + 5, y: stripeY - 5)
        let wind1_radius: CGFloat = 5
        //let wind1_moveTo = CGPoint(x: stripeX + 10, y: stripeY - 10)
        
        //windMutablePath.move(to: wind1_moveTo, transform: .identity)
        //windMutablePath.move(to: wind1_moveTo)
        windMutablePath.addArc(center: wind1_center, radius: wind1_radius, startAngle: CGFloat(Double.pi / 2), endAngle:CGFloat(Double.pi * 3 / 2), clockwise: true)
        //windMutablePath.closeSubpath()
        
        //        let wind1Arc = UIBezierPath(arcCenter: wind1_center, radius: wind1_radius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi * 3 / 2), clockwise: false)
        //
        //        wind1Path.append(wind1Arc)
        
        
        
        
        
        
        
        
        
        
        
        
        // Second wind
        let windStripe_2Start = CGPoint(x: stripeX - 10, y: stripeY + 10)
        let windStripe_2End = CGPoint(x: stripeX + 20, y: stripeY + 10)
        //        windMutablePath.move(to: windStripe_2Start)
        //        windMutablePath.addLine(to: windStripe_2End)
        
        let wind2Path = UIBezierPath()
        wind2Path.move(to: windStripe_2Start)
        wind2Path.addLine(to: windStripe_2End)
        
        
        
        let wind2_center = CGPoint(x: stripeX + 20, y: stripeY + 5)
        let wind2_radius: CGFloat = 5
        //let wind2_moveTo = CGPoint(x: stripeX + 10, y: stripeY - 10)
        
        //windMutablePath.move(to: wind2_moveTo)
        //        windMutablePath.addArc(center: wind2_center, radius: wind2_radius, startAngle: CGFloat(Double.pi / 2), endAngle:CGFloat(Double.pi * 3 / 2), clockwise: true)
        
        let wind2Arc = UIBezierPath(arcCenter: wind2_center, radius: wind2_radius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi * 3 / 2), clockwise: false)
        
        wind2Path.append(wind2Arc)
        
        
        
        
        
        
        
        
        // Third wind
        let windStripe_3Start = CGPoint(x: stripeX - 20, y: stripeY + 20)
        let windStripe_3End = CGPoint(x: stripeX + 5, y: stripeY + 20)
        //        windMutablePath.move(to: windStripe_3Start)
        //        windMutablePath.addLine(to: windStripe_3End)
        
        let wind3Path = UIBezierPath()
        wind3Path.move(to: windStripe_3Start)
        wind3Path.addLine(to: windStripe_3End)
        
        
        
        let wind3_center = CGPoint(x: stripeX + 5, y: stripeY + 25)
        let wind3_radius: CGFloat = 5
        //let wind2_moveTo = CGPoint(x: stripeX + 10, y: stripeY - 10)
        
        //windMutablePath.move(to: wind2_moveTo)
        //        windMutablePath.addArc(center: wind3_center, radius: wind3_radius, startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: false)
        
        
        let wind3Arc = UIBezierPath(arcCenter: wind3_center, radius: wind3_radius, startAngle: CGFloat(Double.pi * 3 / 2), endAngle: CGFloat(Double.pi / 2) , clockwise: true)
        
        wind3Path.append(wind3Arc)
        
        windShapeLayer.path = windMutablePath
        windShapeLayer.lineWidth = 4
        windShapeLayer.lineCap = .round
        windShapeLayer.strokeColor = UIColor.red.cgColor
        windShapeLayer.fillColor = UIColor.clear.cgColor
        
        
        //        wind1ShapeLayer.path = wind1Path.cgPath
        //        wind1ShapeLayer.lineWidth = 4
        //        wind1ShapeLayer.lineCap = .round
        //        wind1ShapeLayer.strokeColor = UIColor.red.cgColor
        //        wind1ShapeLayer.fillColor = UIColor.clear.cgColor
        //
        //        wind2ShapeLayer.path = wind2Path.cgPath
        //        wind2ShapeLayer.lineWidth = 4
        //        wind2ShapeLayer.lineCap = .round
        //        wind2ShapeLayer.strokeColor = UIColor.red.cgColor
        //        wind2ShapeLayer.fillColor = UIColor.clear.cgColor
        //
        //        wind3ShapeLayer.path = wind3Path.cgPath
        //        wind3ShapeLayer.lineWidth = 4
        //        wind3ShapeLayer.lineCap = .round
        //        wind3ShapeLayer.strokeColor = UIColor.red.cgColor
        //        wind3ShapeLayer.fillColor = UIColor.clear.cgColor
        
        
        animateWind()
        
        windShapeLayer.addSublayer(wind1ShapeLayer)
        windShapeLayer.addSublayer(wind2ShapeLayer)
        windShapeLayer.addSublayer(wind3ShapeLayer)
        
        
        
        
        
        //windShapeLayer.path = wind1Arc.cgPath
        //windShapeLayer.path = windMutablePath
        //        windShapeLayer.lineWidth = 4
        //        windShapeLayer.lineCap = .round
        //        windShapeLayer.strokeColor = UIColor.red.cgColor
        //        windShapeLayer.fillColor = UIColor.clear.cgColor
        
        print("windshapelayer returned")
        return windShapeLayer
        
    }
    
    func animateWind() {
        
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = 0
        startAnimation.toValue = 0.6
        startAnimation.duration = 2
        startAnimation.repeatCount = .infinity
        startAnimation.autoreverses = true
        startAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = 0.1
        endAnimation.toValue = 1.0
        endAnimation.duration = 2
        endAnimation.repeatCount = .infinity
        endAnimation.autoreverses = true
        endAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let animation = CAAnimationGroup()
        animation.animations = [startAnimation, endAnimation]
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        
        wind1ShapeLayer.add(endAnimation, forKey: "MyAnimation")
        wind2ShapeLayer.add(endAnimation, forKey: "MyAnimation")
        wind3ShapeLayer.add(endAnimation, forKey: "MyAnimation")
        windShapeLayer.add(endAnimation, forKey: "MyAnimation")
        
    }
}

//
//  Cloud.swift
//  Weather
//
//  Created by Joakim Kajan on 30.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class Cloud {
    
    let cloudFrontShapeLayer = CAShapeLayer()
    let cloudBackShapeLayer = CAShapeLayer()
    
    func drawFrontCloud(_ rect: CGRect) -> CAShapeLayer {
        
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
        
        let cloudFrontMutablePath = CGMutablePath()
        cloudFrontMutablePath.move(to: moveTo)
        cloudFrontMutablePath.addArc(center: cloud_1Center_1, radius: cloud_1Radius_1, startAngle: CGFloat(Double.pi / 2), endAngle:CGFloat(Double.pi * 3 / 2), clockwise: false)

        cloudFrontMutablePath.addArc(center: cloud_1Center_2, radius: cloud_1Radius_2, startAngle: CGFloat(Double.pi), endAngle:CGFloat(Double.pi * 7 / 4), clockwise: false)

        cloudFrontMutablePath.addArc(center: cloud_1Center_3, radius: cloud_1Radius_3, startAngle: CGFloat(Double.pi * 4 / 3), endAngle:CGFloat(Double.pi * 11 / 6), clockwise: false)

        cloudFrontMutablePath.addArc(center: cloud_1Center_4, radius: cloud_1Radius_4, startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: false)
        cloudFrontMutablePath.closeSubpath()

        cloudFrontShapeLayer.path = cloudFrontMutablePath
        
        cloudFrontShapeLayer.shadowColor = UIColor.black.cgColor
        cloudFrontShapeLayer.shadowOpacity = 1
        cloudFrontShapeLayer.shadowRadius = 5
        cloudFrontShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        cloudFrontShapeLayer.lineWidth = 3
        cloudFrontShapeLayer.strokeColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0).cgColor
        cloudFrontShapeLayer.fillColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0).cgColor
        
        return cloudFrontShapeLayer
    }
    
    func drawBackCloud(_ rect: CGRect) -> CAShapeLayer {
     
        let cloudBackMutablePath = CGMutablePath()
        
        let cloud2X = rect.origin.x
        let cloud2Y = rect.origin.y - 10 //Offset so that cloud 'peeks'
        
        let cloud_2Center_1 = CGPoint(x: cloud2X - 10, y: cloud2Y)
        let cloud_2Radius_1: CGFloat = 10
        
        let cloud_2Center_2 = CGPoint(x: cloud2X, y: cloud2Y - 10)
        let cloud_2Radius_2: CGFloat = 10
        
        let cloud_2Center_3 = CGPoint(x: cloud2X + 15, y: cloud2Y - 5)
        let cloud_2Radius_3: CGFloat = 15
        
        let cloud_2Center_4 = CGPoint(x: cloud2X + 30, y: cloud2Y)
        let cloud_2Radius_4: CGFloat = 10
        
        let moveTo = CGPoint(x: cloud2X - 10, y: cloud2Y + 10)
        
        cloudBackMutablePath.move(to: moveTo)
        cloudBackMutablePath.addArc(center: cloud_2Center_1, radius: cloud_2Radius_1, startAngle: CGFloat(Double.pi / 2), endAngle:CGFloat(Double.pi * 3 / 2), clockwise: false)
        
        cloudBackMutablePath.addArc(center: cloud_2Center_2, radius: cloud_2Radius_2, startAngle: CGFloat(Double.pi), endAngle:CGFloat(Double.pi * 7 / 4), clockwise: false)
        
        cloudBackMutablePath.addArc(center: cloud_2Center_3, radius: cloud_2Radius_3, startAngle: CGFloat(Double.pi * 4 / 3), endAngle:CGFloat(Double.pi * 11 / 6), clockwise: false)
        
        cloudBackMutablePath.addArc(center: cloud_2Center_4, radius: cloud_2Radius_4, startAngle: CGFloat(Double.pi * 3 / 2), endAngle:CGFloat(Double.pi / 2), clockwise: false)
        cloudBackMutablePath.closeSubpath()
        
        cloudBackShapeLayer.path = cloudBackMutablePath
        
        cloudBackShapeLayer.shadowColor = UIColor.black.cgColor
        cloudBackShapeLayer.shadowOpacity = 1
        cloudBackShapeLayer.shadowRadius = 5
        cloudBackShapeLayer.shadowOffset = CGSize(width: 5, height: 5)
        
        cloudBackShapeLayer.lineWidth = 2
        cloudBackShapeLayer.strokeColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0).cgColor
        cloudBackShapeLayer.fillColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0).cgColor
        
        animateCloud()
        
        return cloudBackShapeLayer
    }
    
    func animateCloud() {

        let cloudPositionAnimation = CABasicAnimation(keyPath: "position")
        cloudPositionAnimation.fromValue = [0, 0]
        cloudPositionAnimation.toValue = [-20, 0]
        cloudPositionAnimation.repeatCount = .infinity
        cloudPositionAnimation.autoreverses = true
        cloudPositionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        cloudPositionAnimation.duration = 3.0
        cloudPositionAnimation.repeatCount = .greatestFiniteMagnitude
        
        cloudBackShapeLayer.add(cloudPositionAnimation, forKey: "position")
        
    }
}

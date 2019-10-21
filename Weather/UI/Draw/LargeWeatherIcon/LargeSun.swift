//
//  LargeSun.swift
//  Weather
//
//  Created by Joakim Kajan on 04.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit


class LargeSun {
    
    func drawSun(_ rect: CGRect) -> CAShapeLayer {
        
        let sunLayer = CAShapeLayer()
        
        let sunX = rect.origin.x
        let sunY = rect.origin.y
        let sunCenter = CGPoint(x: sunX, y: sunY)
        let sunMoveTo = CGPoint(x: sunX, y: sunY)
        
        var radius = 40
        var opacity = 1.0
        
        for i in 1...3 {
            
            let sunMutablePath = CGMutablePath()
            let sunShapeLayer = CAShapeLayer()
            sunMutablePath.move(to: sunMoveTo)
            sunMutablePath.addArc(center: sunCenter, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
            sunMutablePath.closeSubpath()
            
            sunShapeLayer.path = sunMutablePath
            sunShapeLayer.fillColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
            sunShapeLayer.opacity = Float(opacity)
            
            if i == 1 {
                opacity = opacity - 0.8
            }else{
                opacity = opacity - 0.05
            }
            radius = radius + 15
            sunLayer.addSublayer(sunShapeLayer)
        }
        return sunLayer
    }
}

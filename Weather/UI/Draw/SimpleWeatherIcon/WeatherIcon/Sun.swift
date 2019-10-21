//
//  Sun.swift
//  Weather
//
//  Created by Joakim Kajan on 27.03.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class Sun {
    
    func drawSun() -> CAShapeLayer {
        
        let sunLayer = CAShapeLayer()
        let sunCenter = CGPoint(x: 0, y: 0)
        
        var radius = 20
        var opacity = 1.0
        
        for i in 1...3 {
            
            let sunMutablePath = CGMutablePath()
            let sunShapeLayer = CAShapeLayer()
            sunMutablePath.addArc(center: sunCenter, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
            sunMutablePath.closeSubpath()
            
            sunShapeLayer.path = sunMutablePath
            sunShapeLayer.fillColor = UIColor.orange.cgColor
            sunShapeLayer.opacity = Float(opacity)
            
            if i == 1 {
                opacity = opacity - 0.8
            }else{
                opacity = opacity - 0.05
            }
            radius = radius + 5
            sunLayer.addSublayer(sunShapeLayer)
        }
        return sunLayer
    }
    
    
    
}




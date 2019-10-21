//
//  LargeMoon.swift
//  Weather
//
//  Created by Joakim Kajan on 04.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class LargeMoon {
    
    
    
    func drawMoon(_ rect: CGRect) -> CAShapeLayer {

        let moonLayer = CAShapeLayer()
        
        let moonX = rect.origin.x
        let moonY = rect.origin.y
        let moonCenter = CGPoint(x: moonX, y: moonY)
        
        let moonPath = CGMutablePath()
        moonPath.addArc(center: moonCenter, radius: CGFloat(30), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        moonPath.closeSubpath()
        
        moonLayer.path = moonPath
        moonLayer.fillColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        moonLayer.shadowColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor
        moonLayer.shadowRadius = 10
        moonLayer.shadowOpacity = 1
        
        return moonLayer
        
    }
    
}

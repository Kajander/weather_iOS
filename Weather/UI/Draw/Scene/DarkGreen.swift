//
//  DarkGreen.swift
//  Weather
//
//  Created by Joakim Kajan on 06.10.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class DarkGreen {
    
    func draw(_ rect: CGRect) {
        
        // First vuori
        let path4 = UIBezierPath()
        path4.move(to: CGPoint(x: rect.minX, y: rect.height / 5))
        path4.addCurve(to: CGPoint(x: rect.width / 2, y: rect.height / 5 * 3), controlPoint1: CGPoint(x: rect.minX + 50, y: 100), controlPoint2: CGPoint(x: rect.width / 5, y: 300))
        path4.addLine(to: CGPoint(x: rect.minX, y: rect.height / 5 * 3))
        path4.close()
        UIColor(red:0.02, green:0.18, blue:0.16, alpha:1.0).set()
        path4.fill()
        
        // Water
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: rect.minX, y: rect.height / 5 * 3))
        path3.addLine(to: CGPoint(x: rect.maxX, y: rect.height / 5 * 3))
        path3.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path3.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path3.close()
        UIColor(red:0.07, green:0.54, blue:0.48, alpha:1.0).set()
        path3.fill()
        
        // Back kumpu
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: rect.minX, y: rect.maxY - 150))
        path2.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY - 50), controlPoint: CGPoint(x: rect.width / 2, y: rect.maxY - 100))
        path2.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path2.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path2.close()
        UIColor(red:0.04, green:0.30, blue:0.27, alpha:1.0).set()
        path2.fill()

        // Front kumpu
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: rect.maxX, y: rect.maxY - 150))
        path1.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - 100), controlPoint: CGPoint(x: rect.width / 2, y: rect.maxY - 150))
        path1.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path1.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path1.close()
        UIColor(red:0.03, green:0.24, blue:0.21, alpha:1.0).set()
        path1.fill()
        
        
    }
}

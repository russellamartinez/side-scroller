//
//  CGVector+Utilities.swift
//  side-scroller
//
//  Created by russell martinez on 8/31/22.
//

import SpriteKit

extension CGVector {
    
    static func unitVector(point1: CGPoint, point2: CGPoint) -> CGVector {
 
        var a = point1.x - point2.x
        var b = point1.y - point2.y
       
        // calc magnitude
        let m = sqrt(a*a+b*b)
      
        // calc unit vector
        a = a/m
        b = b/m
        
        return CGVector(dx: a, dy: b)
    }
}

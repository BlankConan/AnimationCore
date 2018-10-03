//
//  Float.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/26.
//  Copyright © 2018 liu gangyi. All rights reserved.
//

import Foundation
import UIKit
import GLKit

// MARK: 角度转弧度
// 整数
extension Int {
    // 角度 -> 弧度
    var degreesToRadians: CGFloat { return CGFloat(self) * CGFloat.pi / 180}
}

// 浮点数
extension FloatingPoint {
    
    // 角度 -> 弧度
    var degreesToRadians: Self { return self * .pi / 180 }
    
    // 弧度 -> 角度
    var radiansToDegrees: Self { return self * 180 / .pi }
    
}

// MARK: Transform3D 转 GLKMatrix4

extension CATransform3D {
    var toGLKMatrix4: GLKMatrix4 {
        return GLKMatrix4Make(Float(self.m11), Float(self.m12), Float(self.m13), Float(self.m14),
                              Float(self.m21), Float(self.m22), Float(self.m23), Float(self.m24),
                              Float(self.m31), Float(self.m32), Float(self.m33), Float(self.m34),
                              Float(self.m41), Float(self.m42), Float(self.m43), Float(self.m44))
    }
}


func printFontNames() {
    for familay in UIFont.familyNames {
        for font in UIFont.fontNames(forFamilyName: familay) {
            NSLog(font)
        }
    }
}



//
//  Layer3DVC.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/26.
//  Copyright © 2018 liu gangyi. All rights reserved.
//

import UIKit
import GLKit



class LayerSolidBody: UIViewController {

    lazy var contanerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 100, y: 120, width: 300, height: 300)
        view.center = self.view.center
        return view
    }()
    
    var faces = [UIView]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加容器
        view.backgroundColor = .lightGray
        view.addSubview(contanerView)
        
        // Make six faces
        for i in 1...6 {
            let face = createFace(index: i)
            faces.append(face)
        }
        
        var perspective = CATransform3DIdentity
//        perspective.m34 = -1.0 / 500
        contanerView.layer.sublayerTransform = perspective
        perspective = CATransform3DRotate(perspective, CGFloat(-45.degreesToRadians), 1, 0, 0);
        perspective = CATransform3DRotate(perspective, CGFloat(-45.degreesToRadians), 0, 1, 0);
        contanerView.layer.sublayerTransform = perspective
        // add face 1
        let ft1 = CATransform3DMakeTranslation(0, 0, 100)
        addFaceWithTransform(faceIndex: 1, transform: ft1)
        
        // add face 2
        var ft2 = CATransform3DMakeTranslation(100, 0, 0)
        ft2 = CATransform3DRotate(ft2, CGFloat(90.degreesToRadians), 0, 1, 0)
        addFaceWithTransform(faceIndex: 2, transform: ft2)
        
        // add face 3
        var ft3 = CATransform3DMakeTranslation(0, -100, 0)
        ft3 = CATransform3DRotate(ft3, CGFloat(90.degreesToRadians), 1, 0, 0)
        addFaceWithTransform(faceIndex: 3, transform: ft3)
        
        // add face 4
        var ft4 = CATransform3DMakeTranslation(0, 100, 0)
        ft4 = CATransform3DRotate(ft4, CGFloat(-90.degreesToRadians), 1, 0, 0)
        addFaceWithTransform(faceIndex: 4, transform: ft4)
        
        // add face 5
        var ft5 = CATransform3DMakeTranslation(-100, 0, 0)
        ft5 = CATransform3DRotate(ft5, CGFloat(-90.degreesToRadians), 0, 1, 0)
        addFaceWithTransform(faceIndex: 5, transform: ft5)
        
        // add face 6
        var ft6 = CATransform3DMakeTranslation(0, 0, -100)
        ft6 = CATransform3DRotate(ft6, CGFloat(180.degreesToRadians), 0, 1, 0)
        addFaceWithTransform(faceIndex: 6, transform: ft6)
        
    }
    
    // 添加光影效果
    func applyLightingToFace(face: CALayer) {
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        
        // convert the face transform to matrix
        // (GLKMatrix4 has the same structure as CATransform3D)
        // GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换
        
        let transform3D = face.transform
        let matrix4 = transform3D.toGLKMatrix4
        let matrix3 = GLKMatrix4GetMatrix3(matrix4)
        
        // get face nomal
        var normal = GLKVector3Make(0, 0, 1)
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        
        let light = GLKVector3Normalize(GLKVector3Make(0, 1, -0.5))
        let dotProduct = GLKVector3DotProduct(light, normal)
        
        // set lighting layer opacity
        let shadow = CGFloat(1 + dotProduct - 0.5)
        let color = UIColor(white: 0, alpha: shadow)
        layer.backgroundColor = color.cgColor;
    }
    
    // 添加面
    func addFaceWithTransform(faceIndex index: Int, transform: CATransform3D) {
        let face = faces[index-1]
        contanerView.addSubview(face)
        let contanerSize = contanerView.bounds.size
        face.center = CGPoint(x: contanerSize.width/2, y: contanerSize.height/2)
        face.layer.transform = transform
        applyLightingToFace(face: face.layer)
    }

    // 创建面
    func createFace(index: Int) -> UIView {
        let bview = UIView()
        bview.backgroundColor = .white
        bview.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        bview.layer.borderWidth = 0.5
        bview.layer.borderColor = UIColor.black.cgColor
        let lab = UILabel()
        lab.text = String(index)
        bview.addSubview(lab)
        lab.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        lab.center = CGPoint(x: bview.bounds.size.width/2, y: bview.bounds.size.height/2)
        return bview
    }

}

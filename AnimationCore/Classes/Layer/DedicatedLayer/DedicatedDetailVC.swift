//
//  DedicatedDetailVC.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/27.
//  Copyright © 2018 liu gangyi. All rights reserved.
//

import UIKit


class DedicatedDetailVC: UIViewController {

    let layerName: String
    
    init(layerName: String) {
        self.layerName = layerName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        reflectEffects()
        
    }
    
    // MARK: CATextLayer
    func textLayer() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 20, y: 100, width: 200, height: 100)
        textLayer.borderColor = UIColor.orange.cgColor
        textLayer.borderWidth = 0.5
        view.layer.addSublayer(textLayer)
        
        // 属性和lab的相似
        textLayer.foregroundColor = UIColor.red.cgColor
//        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.isWrapped = true
        textLayer.contentsScale = UIScreen.main.scale
        
        // 设置font
//        let font: CTFont = CTFontCreateWithName("Cochin-BoldItalic" as CFString, 10, nil)
//        textLayer.font = font
//        textLayer.fontSize = 10
        
        // attributeString & 段落格式
        let attrParagraphStyle = NSMutableParagraphStyle()
        attrParagraphStyle.lineSpacing = 2
        attrParagraphStyle.paragraphSpacing = 3
        attrParagraphStyle.firstLineHeadIndent = 5
        let str: String = "AABCDBBSDLKFJSLKDJFLKSDJFLSDFSDFSDFEFGHI \nGHJKHGHJKLKJHG"
        let attStr = NSMutableAttributedString(string: str)
        attStr.addAttributes([NSAttributedString.Key.paragraphStyle : attrParagraphStyle], range: NSRange(location: 0, length: str.count))
        attStr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], range: NSRange(location: 0, length: str.count))
        attStr.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], range: NSRange(location: 0, length: str.count))
        textLayer.string = attStr
    
    }
    
    // MARK: TransformLayer 创建一个立方体
    func transformLayer() {
        
        self.view.backgroundColor = .lightGray
        
        let contaner = UIView()
        contaner.backgroundColor = .white
        contaner.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        contaner.center = self.view.center
        self.view.addSubview(contaner)
        // 做透视
        var pt = CATransform3DIdentity
        pt.m34 = -1.0 / 500.0
        contaner.layer.sublayerTransform = pt
        
        // 做其他效果
        var ct = CATransform3DIdentity
        ct = CATransform3DMakeRotation(-45.degreesToRadians, 1, 0, 0)
        ct = CATransform3DRotate(ct, -45.degreesToRadians, 0, 1, 0)
        let layer = cubeTransform(transform: ct)
        layer.frame = contaner.bounds
        contaner.layer.addSublayer(layer)
        
    }
    
    // 创建每个面
    func faceWithTransform(transform: CATransform3D) -> CALayer {
        
        let face = CALayer()
        
        let r = CGFloat(arc4random()) / CGFloat(INT32_MAX) / 2.0
        let g = CGFloat(arc4random()) / CGFloat(INT32_MAX) / 2.0
        let b = CGFloat(arc4random()) / CGFloat(INT32_MAX) / 2.0
        let backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0).cgColor
        face.backgroundColor = backgroundColor
        face.transform = transform
        face.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        face.position = CGPoint(x: 150, y: 150)
        return face
    }
    
    //
    func cubeTransform(transform: CATransform3D) -> CATransformLayer {
        let faceContainer = CATransformLayer(layer: CALayer.self)
        
        // face1
        var ct = CATransform3DMakeTranslation(0, 0, -100)
        let face1 = faceWithTransform(transform: ct)
        faceContainer.addSublayer(face1)

        // face2
        ct = CATransform3DMakeTranslation(0, 0, 100)
        let face2 = faceWithTransform(transform: ct)
        faceContainer.addSublayer(face2)

        // face3
        ct = CATransform3DMakeTranslation(-100, 0, 0)
        ct = CATransform3DRotate(ct, 90.degreesToRadians, 0, 1, 0)
        let face3 = faceWithTransform(transform: ct)
        faceContainer.addSublayer(face3)

        // face4
        ct = CATransform3DMakeTranslation(100, 0, 0)
        ct = CATransform3DRotate(ct, 90.degreesToRadians, 0, 1, 0)
        let face4 = faceWithTransform(transform: ct)
        faceContainer.addSublayer(face4)

        // face5
        ct = CATransform3DMakeTranslation(0, -100, 0)
        ct = CATransform3DRotate(ct, 90.degreesToRadians, 1, 0, 0)
        let face5 = faceWithTransform(transform: ct)
        faceContainer.addSublayer(face5)

        // face6
        ct = CATransform3DMakeTranslation(0, 100, 0)
        ct = CATransform3DRotate(ct, 90.degreesToRadians, 1, 0, 0)
        let face6 = faceWithTransform(transform: ct)
        faceContainer.addSublayer(face6)
        
        faceContainer.transform = transform
        
        return faceContainer
    }
    
    
    // MARK: GradientLayer
    func gradient() {
        
        let lab = UILabel()
        lab.text = "啊速度快解放啦看时间阿斯加德理发卡了\n发牢骚的家乐福卡时代峰峻拉克丝见多了"
        lab.frame = CGRect(x: 30, y: 100, width: 200, height: 100)
        lab.numberOfLines = 0
        self.view.addSubview(lab)
        
        let layer = CAGradientLayer()
        
        layer.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor]
//        layer.locations
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.type = CAGradientLayerType.conic
        lab.layer.addSublayer(layer)
        layer.frame = lab.bounds
    }
    
    
    // MARK: CAReplicatorLayer 高效生成许多相似的图层
    
    func replicatorLayer() {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.lightGray
        view.addSubview(containerView)
        containerView.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 200)
        
        let repLayer = CAReplicatorLayer()
        repLayer.frame = containerView.bounds
        containerView.layer.addSublayer(repLayer)
        repLayer.instanceCount = 6
        
        // apply a transform for each instance
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 50, 0)
        transform = CATransform3DRotate(transform, 60.degreesToRadians, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -50, 0)
        repLayer.instanceTransform = transform
        
        // apply a color shift for each instance
//        repLayer.instanceColor = UIColor.black.cgColor
        repLayer.instanceRedOffset = -0.2
        repLayer.instanceBlueOffset = -0.2
        
        // create a sublayer and place it inside the replicator
        
        let containerLayer = CALayer()
        containerLayer.frame = CGRect(x: 50, y: 150, width: 50, height: 50)
        repLayer.addSublayer(containerLayer)
        containerLayer.backgroundColor = UIColor.orange.cgColor
        
    }
    
    
    // 使用ReplicatorLayer制作反射效果
    func reflectEffects() {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 200)
        view.addSubview(containerView)
        
        let layer = CAReplicatorLayer()
        containerView.layer.addSublayer(layer)
        layer.frame = CGRect(x: (containerView.bounds.width - 50)/2, y: 20, width: 50, height: 100)
        layer.instanceCount = 2
        
        // move reflection instance below original and flip vertically
        var transfrom3d = CATransform3DIdentity
        transfrom3d = CATransform3DTranslate(transfrom3d, 0, layer.bounds.height, 0)
        transfrom3d = CATransform3DScale(transfrom3d, 1, -1, 0)
        
        layer.instanceTransform = transfrom3d
        layer.instanceAlphaOffset = -0.6
        
        let aa = CALayer()
        aa.backgroundColor = UIColor.orange.cgColor
        aa.frame = layer.bounds
        layer.addSublayer(aa)
    }
    
    // MARK: CATiledLayer 为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入
    func loadLargeImage() {
//        let tiledLayer = CATiledLayer()
//        let filePath = Bundle.main.path(forResource: "large", ofType: "jpeg")
//        let tileSize = 256
    }
    
    
    // MARK: OpenGL渲染
    func openGL() {
        
    }

}

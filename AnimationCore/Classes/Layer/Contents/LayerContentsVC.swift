//
//  LayerContentsVC.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/21.
//  Copyright © 2018年 liu gangyi. All rights reserved.
//

import UIKit


/// 寄宿图
class LayerContentsVC: UIViewController {
    
    lazy var greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        self.view.addSubview(v)
        return v
    }()
    
    lazy var opaView: UIView = {
        let v = UIView()
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.borderWidth = 1
        self.view.addSubview(v)
        return v
    }()
    
    lazy var blankLayer: CALayer = {
        let layer = CALayer()
        self.view.layer.addSublayer(layer)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray

        greenView.frame = CGRect(x: 20, y: 100, width: 100, height: 50);
        opaView.frame = CGRect(x: 20, y: 170, width: 100, height: 50);
        setupContents()
        
    }
    
    
    func setupContents() {
        let image1 = UIImage(named: "alpha.jpg", in: nil, compatibleWith: nil);
//        let image = UIImage(named: "sunshine.jpg", in: nil, compatibleWith: nil);
        
        blankLayer.frame = CGRect(x: 20, y: 250, width: 350, height: 250)
        blankLayer.contents = image1?.cgImage
        blankLayer.borderColor = UIColor.black.cgColor
        blankLayer.borderWidth = 0.5
        blankLayer.contentsGravity = .resizeAspect
        blankLayer.contentsScale = UIScreen.main.scale

//        blankLayer.contentsRect = CGRect(x: 0, y: 0, width: 0.5, height: 1)
        
//        blankLayer.contentsCenter = CGRect(x: 0, y: 0, width: 0.75, height: 0.75)
    }
}

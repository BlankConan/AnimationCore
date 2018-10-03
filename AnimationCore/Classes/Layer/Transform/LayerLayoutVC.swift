//
//  LayerLayoutVC.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/21.
//  Copyright © 2018年 liu gangyi. All rights reserved.
//

import UIKit

// 父坐标系 center  position  anchorPoint  仿射变换 3D变换
// position 是 锚点在父视图中的位置，并且等价于view中的center
// position 和 center的值永远是相等的

/// frame bounds center position anchorPoint
class LayerLayoutVC: UIViewController {

    lazy var orangeView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var view3D: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    
    func setupView() {
        self.view.addSubview(orangeView)
        
        orangeView.frame = CGRect(x: 20, y: 100, width: 200, height: 120)
        greenView.frame = CGRect(x: 20, y: 20, width: 160, height: 80)
        orangeView.addSubview(greenView)
        view3D.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        view.addSubview(view3D)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    

    // position = center 改变position
    func changeAnchorPoint() {
        let arr: Array<Double> = [0.0, 0.5, 1.0]
        let point = greenView.layer.position
        greenView.layer.position = CGPoint(x: point.x+10, y: point.y+10)
        greenView.layer.anchorPoint =  CGPoint(x: arr[count%3], y: arr[count%3])
        count = count + 1
        
    }
    
    // 改变center
    func changeCenter() {
        let point = greenView.center
        greenView.center = CGPoint(x: point.x+10, y: point.y+10)
    }
    
    
    /// 仿射变换
    func affineTransform() {
        
        
        /**
         // 默认的变换坐标
         CGAffineTransform.identity
         // 如果不是基于一个变换做变换，那么都是以identity为基准做变换
        */
    }

    
    // 3D变换
    func transform3D() {
        
        var t = view3D.layer.transform
//        let angle: CGFloat = CGFloat(45.degreesToRadians)
//        t = CATransform3DRotate(t, angle, 0, 0, 1)
//        view3D.layer.transform = t
//        t = CATransform3DScale(t, 2, 2, 0)
//        view3D.layer.transform = t
        
        let tA = CATransform3DTranslate(t, 20, 20, 0)
        let tB = CATransform3DScale(t, 1, 1, 0)
        t = CATransform3DConcat(tA, tB)
        NSLog("%@", String(reflecting: t))
        view3D.layer.transform = t
    }
    
    /// 打印函数
    ///
    /// - Parameter layer: layer属性
    func printMSG(view: UIView) {
        NSLog(" frame       %@", String(reflecting: view.frame))
        NSLog(" bounds      %@", String(reflecting: view.bounds))
        NSLog(" center      %@", String(reflecting: view.center))
        NSLog(" position    %@", String(reflecting: view.layer.position))
        NSLog(" anchorPoint %@", String(reflecting: view.layer.anchorPoint))
    }

}




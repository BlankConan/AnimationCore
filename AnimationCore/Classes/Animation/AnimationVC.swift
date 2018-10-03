
//
//  AnimationVC.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/29.
//  Copyright © 2018 liu gangyi. All rights reserved.
//

import UIKit

/// 隐式动画
/*
 隐式动画:之所以叫隐式是因为我们并没有指定任何动画的类型。
 我们仅仅改变了一个属性，然后Core Animation来决定如何并且何时去做动画。
 Core Animaiton同样支持显式动画。
 
 实际上动画执行的时间取决于当前事务的设置，动画类型取决于图层行为。事务是通过CATransaction类来做管理,
 Core Animation在每个run loop周期中自动开始一次新的事务,即使你不显式的用[CATransaction begin]开始一次事务，
 任何在一次run loop循环中属性的改变都会被集中起来，然后做一次0.25秒的动画
 
 隐式动画作用于layer层，好像被UIView关联图层给禁用了，要是没被禁用的话，无论在什么时候修改它，我们都应该能注意到的
 
 */

/*
 UIView怎么禁用动画实现呢？
 
 当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称。
 剩下的操作都在CALayer的头文件中有详细的说明，实质上是如下几步：
 1. 图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。
 如果有，直接调用并返回结果。
 2. 如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
 如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
 3. 最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的 -defaultActionForKey:方法。
 
 所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），
 要么是CAAction协议对应的对象，最后CALayer拿这个结果去对先前和当前的值做动画。
 于是这就解释了UIKit是如何禁用隐式动画的：每个UIView对它关联的图层都扮演了一个委托，
 并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，
 但是在动画block范围之内，它就返回了一个非空值。
 */

class AnimationVC: UIViewController {

    lazy var actionView: UIView = {
       let viewa = UIView()
        viewa.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        viewa.backgroundColor = .orange
        return viewa
    }()
    
    lazy var actionLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 50, y: 300, width: 50, height: 50)
        layer.backgroundColor = UIColor.red.cgColor
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(actionView)
        self.view.layer.addSublayer(actionLayer)
        
        animationWithActions()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.actionLayer.backgroundColor = UIColor.black.cgColor
        self.actionLayer.opacity = 0.5
    }
    
    func animationForView() {
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            
            var transform = CATransform3DMakeTranslation(50, 100, 0)
            transform = CATransform3DRotate(transform, 45.degreesToRadians, 0, 0, 1)
            self.actionView.layer.transform = transform
            
        }
        
        CATransaction.setAnimationDuration(1.0)
        actionView.backgroundColor = UIColor.blue
        CATransaction.commit()
    }
    
    func animationForLayer() {
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        CATransaction.setCompletionBlock {
            var transform = CATransform3DMakeTranslation(50, 100, 0)
            transform = CATransform3DRotate(transform, 45.degreesToRadians, 0, 0, 1)
            self.actionLayer.transform = transform
        }
        actionLayer.backgroundColor = UIColor.orange.cgColor
        CATransaction.commit()
    }
    
    // 通过actions字典做动画
    
    func animationWithActions() {

        // 推进过渡背景色
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        
        
        // alpha
//        let alphaTransition = CATransition()
//        alphaTransition.type = .moveIn
//        alphaTransition.subtype = .fromLeft
        
        self.actionLayer.actions = ["backgroundColor": transition]
    }
    
}

extension AnimationVC: CALayerDelegate, CAAnimationDelegate {
    
}

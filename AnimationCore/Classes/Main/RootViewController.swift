//
//  ViewController.swift
//  AnimationCore
//
//  Created by liu gangyi on 2018/9/21.
//  Copyright © 2018年 liu gangyi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    let tabBar: BaseTabBarController = {
        let tabBar = BaseTabBarController()
//        tabBar.view.frame = UIScreen.main.bounds
        return tabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTabBar()
        setupViewcontrollers()
    }
    
    func setupTabBar() {
        self.addChild(tabBar)
        self.view.addSubview(tabBar.view)
    }
    
    func setupViewcontrollers() {
        
        
        let layerContents = LayerContentsVC()
        layerContents.title = "Contents"
        let navC = BaseNavigationController.init(rootViewController: layerContents)
        
        let layerLayout = LayerSolidBody()
        layerLayout.title = "Layout"
        let navLayout = BaseNavigationController.init(rootViewController: layerLayout)
        
        let layerDedicatedVC = DedicatedLayerTVC()
        layerDedicatedVC.title = "DedicatedLayer"
        let navDedicatedVC = BaseNavigationController.init(rootViewController: layerDedicatedVC)
        
        let animationVC = AnimationVC()
        animationVC.title = "Animation"
        let navAnimation = BaseNavigationController(rootViewController: animationVC)
        
        tabBar.setViewControllers([navAnimation, navC, navLayout, navDedicatedVC], animated: true)
    }

    
}


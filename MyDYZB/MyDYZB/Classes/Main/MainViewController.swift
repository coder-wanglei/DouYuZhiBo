//
//  MainViewController.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/11.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //标签栏颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        addChildVC(storyboardName: "Home")
        addChildVC(storyboardName: "Live")
        addChildVC(storyboardName: "Follow")
        addChildVC(storyboardName: "Discover")
        addChildVC(storyboardName: "Profile")
        
    }

    private func addChildVC(storyboardName:String){
        //1、通过storyboard获取控制器（对可选类型进行解包） 2、添加自控制器
        let childVC = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }

}

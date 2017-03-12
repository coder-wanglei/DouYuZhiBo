//
//  UIBarButtonItem-Extention.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/11.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    //创建自定义item
    class func createItem(imageName:String,highlightImageName:String,size:CGSize) ->UIBarButtonItem {
        let button = UIButton()
        button.frame = CGRect.init(origin: CGPoint.zero, size: size)
        button.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        button.setImage(UIImage.init(named: highlightImageName), for: UIControlState.highlighted)
        
        return UIBarButtonItem.init(customView: button)
    }
    //便利构造函数 :1、convenience 开头  2、在构造函数中必须明确调用一个设计的构造函数(self)  类型后面用=号为设置默认值
    convenience init(imageName:String,highlightImageName:String = "",size:CGSize = CGSize.zero) {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        if highlightImageName != ""{
            button.setImage(UIImage.init(named: highlightImageName), for: UIControlState.highlighted)
        }
        //判断大小
        if size == CGSize.zero {
            button.sizeToFit()
        }else{
            button.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }
        self.init(customView:button)
    }
}

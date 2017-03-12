//
//  PageTitleView.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/11.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    //MARK: -定义属性
    private var titles:[String]
    
    
    // MARK: - 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    

}

//
//  UIColor-Extention.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/12.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) {
        self.init(red: a/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

}

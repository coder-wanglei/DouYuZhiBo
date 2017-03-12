//
//  HomeViewController.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/11.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: -懒加载属性
//    private lazy var pageTitleView:PageTitleView = {
//        let titleView = PageTitleView(frame:)
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
    }


}

// MARK:  设置UI界面
extension HomeViewController{
    func setupUI(){
        //设置导航栏
        setupNavigationBar()
    }
    private func setupNavigationBar(){
        //左侧logo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"logo")
        //右侧按钮
        let size = CGSize.init(width: 40, height: 40)
        //便利构造函数
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightImageName: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem(imageName: "Image_scan", highlightImageName: "Image_scan_click", size: size)
        let historyItem = UIBarButtonItem(imageName: "Image_my_history", highlightImageName: "Image_my_history_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }
}

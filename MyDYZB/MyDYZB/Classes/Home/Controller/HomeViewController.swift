//
//  HomeViewController.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/11.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import UIKit

private let kTitleViewHeight:CGFloat = 40

class HomeViewController: UIViewController,PageTitleViewDelegate,PageContentViewDelegate {

    //MARK: -懒加载属性
    lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect.init(x: 0, y: KStatusBarH+kNavigationBarH, width: kScreenW, height:kTitleViewHeight )
        let titles = ["推荐","手游","娱乐","游戏","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self as? PageTitleViewDelegate  //设置代理
        return titleView
    }()
    
    lazy var pageContentView:PageContentView = {[weak self] in //闭包内若引用处理
        //frame
        let originY = KStatusBarH + kNavigationBarH + kTitleViewHeight
        let frame:CGRect = CGRect.init(x: 0, y:originY , width: kScreenW, height: kScreenH - originY)
        //添加子控制器
        var viewControllers = [UIViewController]()
        for _ in 0..<5{
            let vc = UIViewController()
            let randomFloat:CGFloat = CGFloat(arc4random_uniform(255))
            vc.view.backgroundColor = UIColor.init(r: randomFloat, g: randomFloat, b: randomFloat, a: 1.0)
            viewControllers.append(vc)
        }
        let pageContent = PageContentView.init(frame: frame, childViewControllers: viewControllers, parentViewController: self!)//可选类型
        pageContent.delegate = self
        return pageContent
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
    }


}

// MARK:  设置UI界面
extension HomeViewController{
    func setupUI(){
        //0、不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1、设置导航栏
        setupNavigationBar()
        //2、添加TitleView
        view.addSubview(pageTitleView)
        //3、添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    private func setupNavigationBar(){
        //左侧logo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"logo")
        //右侧按钮
        let size = CGSize.init(width: 40, height: 40)
        //便利构造函数
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightImageName: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem(imageName: "Image_scan", highlightImageName: "Image_scan_click", size: size)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightImageName: "Image_my_history_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }
}

//MARK: - 遵守PageTitleViewDelegate
extension HomeViewController{

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        print(index)
        //1、将点击标签的index传递给pageContentView
        pageContentView.setCurrentIndex(currentIndex: index)
    }

}
//MARK: - 遵守PageContentViewDelegate
extension HomeViewController{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //将collectionView滑动的参数传给titleView
        pageTitleView.setTitleWithProgress(pregress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



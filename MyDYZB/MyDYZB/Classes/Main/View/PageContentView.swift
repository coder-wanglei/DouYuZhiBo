//
//  PageContentView.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/12.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let ContentCellID:String = "ContentCellID"

class PageContentView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK: -定义属性
    weak var delegate:PageContentViewDelegate?
    var childViewControllers:[UIViewController]
    weak var parentViewController:UIViewController! //weak放置循环引用（可选类型）
    var startContentOffSetX:CGFloat = 0  //collectionView开始滑动的x坐标位置
    
    //MARK: -懒加载属性CollectionView
    lazy var collectionView:UICollectionView = {[weak self] in //闭包内若引用处理，放置闭包强引用
        //1、创建Layout
        let layout = UICollectionViewFlowLayout()//流水布局
        layout.itemSize = (self?.bounds.size)! //单元格大小   强制解包 格式
        layout.minimumLineSpacing = 0 //行间距
        layout.minimumInteritemSpacing = 0 //item 间距
        layout.scrollDirection = .horizontal
        
        //2、创建CollectionView
        let collectionView = UICollectionView.init(frame: (self!.bounds), collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    //MARK: -自定义构造函数，传入一个控制器数组和父类控制器
    init(frame: CGRect ,childViewControllers:[UIViewController],parentViewController:UIViewController) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 设置UI界面
extension PageContentView{

    func setupUI()  {
        //1.将所有自控制器添加到父控制器中
        for childVC in childViewControllers{
            parentViewController?.addChildViewController(childVC)//?可选链
        }
        //2、添加CollectionView,用于在cell中存放控制器的view
        addSubview(collectionView)
    }
    
}


//MARK: 遵守UICollectionViewDataSource
extension PageContentView{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1、创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //移除子控件，放置循环添加view
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        //2、给cell设置内容
        let childVC = childViewControllers[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }

}

//MARK: -UICollectionDelegate
extension PageContentView{
    //监听scrollView的滚动
    
    //开始滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startContentOffSetX = scrollView.contentOffset.x //获取开始滑动的横坐标
        print("开始")
        print(startContentOffSetX)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        //1、滚动的进度 progress
        var progress:CGFloat = 0
        //2、源index  sourceIndex
        var sourceIndex:Int = 0
        //3、目标index
        var targetIndex:Int = 0
        

        //判断是滑动方向
        if currentOffSetX > startContentOffSetX {//左滑(>0)
            //计算滚动进度
            progress = currentOffSetX/scrollViewW - floor(currentOffSetX/scrollViewW) //floor 函数 取整
            //计算sourceIndex
            sourceIndex = Int(currentOffSetX / scrollViewW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childViewControllers.count {
                targetIndex = childViewControllers.count - 1
            }
            //完全滑过去
            if currentOffSetX - startContentOffSetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑(<0)
            //计算滚动进度
            progress = 1.0 - (currentOffSetX/scrollViewW - floor(currentOffSetX/scrollViewW)) //floor 函数 取整
            //计算targetIndex
            targetIndex = Int(currentOffSetX / scrollViewW)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childViewControllers.count {
                sourceIndex = childViewControllers.count - 1
            }
        }
        //将progress、sourceIndex、targetIndex 传递给pageTitleView
        //print("progress:\(progress)  sourceIndex:\(sourceIndex)   targetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: -对外暴露的接口
extension PageContentView{
    func setCurrentIndex(currentIndex:Int) {
        //设置滑动位置
        let offsetX:CGFloat = CGFloat(currentIndex) * collectionView.frame.width
        self.collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
}




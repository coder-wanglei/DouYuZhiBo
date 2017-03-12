//
//  PageTitleView.swift
//  MyDYZB
//
//  Created by maybe_mylove on 2017/3/11.
//  Copyright © 2017年 maybe_mylove. All rights reserved.
//

import UIKit

//定义协议
protocol PageTitleViewDelegate:class{
    func pageTitleView(titleView:PageTitleView,selectedIndex index :Int)//selectedIndex外部参数 index 内部参数
}

private let kScrollLineH:CGFloat = 2    //滚动条高度
private let kButtomLineH:CGFloat = 0.5   //底线高度
class PageTitleView: UIView {
    
    //MARK: -定义属性
    var titles:[String]   //标签数组
    var currentIndex:Int = 0 //当前标签下标值
    weak var delegate:PageTitleViewDelegate? //弱类型 代理属性  准守协议
    
    //MARK:  懒加载属性  数组（存放UILable）
    lazy var titleLables:[UILabel] = [UILabel]()
    //MARK: -懒加载属性scrollView
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false// 禁止回到顶部
        scrollView.isPagingEnabled = false //禁止分页效果
        scrollView.bounces = false //禁止超过范围，弹性滑动
        scrollView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        return scrollView
    }()
    
    //MARK: -懒加载属性scrollLine
    lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    
    
    // MARK: - 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
    }
    //swift重写或者自定义构造函数  必须重写这个方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

//MARK: -设置UI界面
extension PageTitleView{
    func setupUI(){
        //1、添加UIScrollView
        addSubview(scrollView)
        //2、添加title对应的lable
        setupTitleLable()
        //3、设置底线和滑动的滑块
        setupBottomMenuAndScrollLine()
    }
    private func setupTitleLable()
    {
        
        //lable
        let lableW:CGFloat = frame.width/CGFloat(titles.count)
        let lableH:CGFloat = frame.height-kScrollLineH
        
        for (index,title) in titles.enumerated() {
            let lable = UILabel()
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = NSTextAlignment.center
            lable.text = title
            let lableX:CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect.init(x: lableX, y: 0, width: lableW, height: lableH)
            //给lable添加手势
            lable.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer.init(target: self, action:#selector(titleLableClick(tapGesture:)))
            lable.addGestureRecognizer(tapGesture)
            
            scrollView.addSubview(lable)//添加到scrollView上
            titleLables.append(lable)//添加lable到数组
            
        }
    
    }
    private func setupBottomMenuAndScrollLine(){
        //1、添加底线
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor.lightGray
        buttomLine.frame = CGRect.init(x: 0, y: frame.height-kButtomLineH, width: frame.width, height: kButtomLineH)
        addSubview(buttomLine)
        //2、添加ScrollLine
        //guard 对可选值进行判断
        guard let firstLable = titleLables.first  else {
            return
        }
        firstLable.textColor = UIColor.orange //第一个按钮颜色
        scrollLine.frame = CGRect.init(x: firstLable.frame.origin.x, y: frame.height-kScrollLineH, width: firstLable.frame.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
        
        
    }
}

//MARK:-监听Lable的点击
extension PageTitleView{
    //事件监听：添加@objc开头
    @objc func titleLableClick(tapGesture:UITapGestureRecognizer){
        //1.获取当前lable
        guard let currentLable = tapGesture.view as? UILabel else {//guard 判断可选类型
            return
        }
        //2、获取之前的label
        let oldLable = titleLables[currentIndex]
        oldLable.textColor = UIColor.darkGray
        //3、获取当前的lable
        currentIndex = currentLable.tag
        currentLable.textColor = UIColor.orange
        //4、滚动条位置发生改变
        let scrollViewX:CGFloat = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { //动画
            self.scrollLine.frame.origin.x = scrollViewX
        }
        //5、通知代理
        self.delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK:对外暴露的方法
extension PageTitleView{
    func setTitleWithProgress(pregress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        
    }

}








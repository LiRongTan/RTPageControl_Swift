//
//  RTPageControl.swift
//  RTPageControl_Swift
//
//  Created by 李荣潭 on 2018/6/15.
//  Copyright © 2018 Lezhizhe. All rights reserved.
//


/**
 自定义PageControl
 */

import UIKit

class RTPageControl: UIControl{
    
   /// 总的page数 default = 0
    public var numberOfPages: Int = 0{
        didSet{
            if numberOfPages == oldValue {
                return;
            }
            if numberOfPages > 1 {
                contentView.isHidden = false;
            }else{
                contentView.isHidden = true;
            }
            self.createComponentsView(number: numberOfPages);
            self.currentPage = 0;
        }
    };
    
    var _currentPage: Int = 0;

    /// 当前所在page default = 0
    public var currentPage: Int = 0{
        didSet{
            self.setCurrentPage(currentPage: currentPage, animated: false);
        }
    };
    
    /// 设置当前的所在位置
    ///
    /// - Parameters:
    ///   - currentPage: 当前所在位置
    ///   - animated: 是否执行动画
    public func setCurrentPage(currentPage:Int, animated:Bool){
        if currentPage == self._currentPage && animated {
            return;
        }
        var page = currentPage;
        
        if currentPage > self.numberOfPages - 1 {
            page = 0;
        }
        if currentPage < 0 {
            page = self.numberOfPages - 1;
        }
        self._currentPage = page;
        self.componentsViewLayout(currentPage: page, animated: animated);
    }
    
    /// 根据pagecount计算组件的最合适size。
    ///
    /// - Parameter pageCount: 组件的有多少个page
    /// - Returns: 组件最合适的size
    public func sizeForNumberOfPages(pageCount: Int) -> CGSize{
        var contentWidth: CGFloat = currentPageIndicatorWidth + itemSpaceWidth;
        contentWidth = contentWidth + (CGFloat(pageCount) - 1) * (pageIndicatorWidth + itemSpaceWidth) - itemSpaceWidth
        return CGSize(width: contentWidth, height: pageIndicatorWidth);
    }
    
    
    //pageControl 组件的样式设置
    
    public var pageIndicatorTintColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1){
        didSet{
            self.currentPage = _currentPage;
        }
    };
    public var currentPageIndicatorTintColor:UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1){
        didSet{
            self.currentPage = _currentPage;
        }
    };
    public var pageIndicatorBorderColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1){
        didSet{
            self.currentPage = _currentPage;
        }
    };
    public var currentPageIndicatorBorderColor:UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1){
        didSet{
            self.currentPage = _currentPage;
        }
    };
    public var pageIndicatorWidth: CGFloat = 8{
        didSet{
            self.currentPage = _currentPage;
        }
    };
    public var currentPageIndicatorWidth: CGFloat = 20{
        didSet{
            self.currentPage = _currentPage;
        }
    };
    public var borderWidth: CGFloat = 0{
        didSet{
            self.currentPage = _currentPage;
        }
    };
    public var itemSpaceWidth: CGFloat = 8{
        didSet{
            self.currentPage = _currentPage;
        }
    };
    
    
    
    
    //放置page的view
    lazy var contentView: UIView = {
        let view = UIView();
        return view;
    }();
    //初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addSubview(contentView);
        self.addGesture();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        contentView.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0);
    }
    ///pageControl 的组件创建
    func createComponentsView(number: Int) -> Void {
        for view in contentView.subviews {
            view.removeFromSuperview();
        }
        var i = 0;
        while i < number {
            let view = UIView();
            view.tag = 100 + i;
            contentView.addSubview(view);
            let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTarget));
            view.addGestureRecognizer(gesture);
            i = i + 1;
        }
    }
    ///pageControl 的组件布局刷新
    func componentsViewLayout(currentPage: Int, animated: Bool) -> Void {
        var recoderView: UIView?;
        var i = 0;
        while i < contentView.subviews.count {
            let view = contentView.viewWithTag(i + 100);
            view?.layer.cornerRadius = CGFloat(pageIndicatorWidth / 2.0);
            var rect = CGRect(x: 0, y: 0, width: 0, height: 0);
            if recoderView != nil{
                rect = (recoderView?.frame)!;
                rect.origin.x = rect.origin.x + rect.size.width + itemSpaceWidth;
            }else{
                rect = CGRect(x: 0, y: 0, width: pageIndicatorWidth, height: pageIndicatorWidth);
            }
            if i == currentPage{
                if animated{
                    UIView.animate(withDuration: 0.5) {
                        view?.backgroundColor = self.currentPageIndicatorTintColor;
                        view?.layer.borderColor = self.currentPageIndicatorBorderColor.cgColor;
                        view?.layer.borderWidth = self.borderWidth;
                    };
                }else{
                    view?.backgroundColor = self.currentPageIndicatorTintColor;
                    view?.layer.borderColor = self.currentPageIndicatorBorderColor.cgColor;
                    view?.layer.borderWidth = self.borderWidth;
                }
                rect.size.width = self.currentPageIndicatorWidth;
            }else{
                if animated{
                    UIView.animate(withDuration: 0.5) {
                        view?.backgroundColor = self.pageIndicatorTintColor;
                        view?.layer.borderColor = self.pageIndicatorBorderColor.cgColor;
                        view?.layer.borderWidth = self.borderWidth;
                    };
                }else{
                    view?.backgroundColor = self.pageIndicatorTintColor;
                    view?.layer.borderColor = self.pageIndicatorBorderColor.cgColor;
                    view?.layer.borderWidth = self.borderWidth;
                }
                rect.size.width = self.pageIndicatorWidth;
            }
            if animated{
                UIView.animate(withDuration: 0.5) {
                    view?.frame = rect;
                };
            }else{
                view?.frame = rect;
            }
            recoderView = view;
            i = i + 1;
        }
        contentView.bounds = CGRect(x: 0, y: 0, width: (recoderView?.frame.size.width)! + (recoderView?.frame.origin.x)!, height: (recoderView?.frame.size.height)!);
        contentView.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0);
    }
    ///给pageControl添加手势
    func addGesture() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_tapGesture(gesture:)));
        self.addGestureRecognizer(tapGesture);
    }
    @objc func _tapGesture(gesture: UITapGestureRecognizer) -> Void {
        let point = gesture.location(in: self);
        if point.x > self.frame.size.width / 2.0 {
            self.setCurrentPage(currentPage: _currentPage + 1, animated: true);
        }else{
            self.setCurrentPage(currentPage: _currentPage - 1, animated: true);
        }
        self.sendActions(for: UIControlEvents.valueChanged);
    }
    @objc func gestureTarget() -> Void {
        
    }
}

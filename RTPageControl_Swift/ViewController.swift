//
//  ViewController.swift
//  RTPageControl_Swift
//
//  Created by 李荣潭 on 2018/6/15.
//  Copyright © 2018 Lezhizhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let pageControl = RTPageControl();
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        pageControl.numberOfPages = 10;
        pageControl.setCurrentPage(currentPage: 4, animated: false);
        pageControl.backgroundColor = UIColor.red;
        pageControl.pageIndicatorWidth = 12;
        pageControl.currentPageIndicatorWidth = 30;
        pageControl.currentPageIndicatorTintColor = UIColor.gray;
        pageControl.pageIndicatorTintColor = UIColor.gray;
        pageControl.borderWidth = 0;
        self.view .addSubview(pageControl);
        
        let scrollView = UIScrollView();
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true);
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        pageControl.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 15);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


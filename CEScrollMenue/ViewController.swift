//
//  ViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/24.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var themeView: CEThemeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addThemeView()
    }
    
    ///添加选择主题的View
    func addThemeView() {
        themeView = CEThemeView(frame: self.view.bounds)
        self.view.addSubview(themeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//
//  ViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/28.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataSource: DataSourceType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = DataSourceTools.createDataSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapShowMenuButton(_ sender: UIButton) {
        let menuVC = CEMenuScrollController(dataSource: self.dataSource)
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
}

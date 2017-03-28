//
//  ViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/28.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var dataSource: Array<Array<CEThemeDataSourceProtocal>>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = DataSourceTools.createDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapButton(_ sender: Any) {
        let selectThemeController = CESelectThemeController(dataSource: self.dataSource)
        
        //获取更新后的DataSource
        selectThemeController.setUpdateDataSourceClosure { (dataSource) in
            DataSourceTools.displayDataSource(dataSource: dataSource)
            self.dataSource = dataSource
        }
        
        self.present(selectThemeController, animated: true) {}
    }
}

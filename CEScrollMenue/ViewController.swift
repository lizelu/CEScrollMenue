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
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapButton(_ sender: Any) {
        let selectThemeController = CESelectThemeController(dataSource: self.dataSource)
        selectThemeController.setUpdateDataSourceClosure { (dataSource) in
            DataSourceTools.displayDataSource(dataSource: dataSource)
        }
        self.present(selectThemeController, animated: true) {}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

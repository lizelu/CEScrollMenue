//
//  CESelectThemeViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit


class CEMenuViewController: UIViewController {

    var menuView: CEMenuView!
    var dataSource: DataSourceType!
    
    init(dataSource: DataSourceType) {
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.addMenuView()
    }
    
    func addMenuView() {
        self.menuView = CEMenuView(dataSource: self.dataSource, frame: CGRect(x: 0, y: 63, width: SCREEN_WIDTH, height: 30))
        self.view.backgroundColor = UIColor.white
        weak var weak_self = self
        self.menuView.setTapSelectThemeClosure {
            weak_self?.presentCESelectThemeController()
        }
        
        self.menuView.setDidSelectItemClosure { (row) in
            self.dataSource = DataSourceTools.setSelcted(dataSource: self.dataSource, index: row)
            self.menuView.updateDataSource(data: self.dataSource)
        }
        
        self.view.addSubview(self.menuView)
    }
    
    func presentCESelectThemeController() {
        let selectThemeController = CESelectThemeController(dataSource: self.dataSource)
        
        //获取更新后的DataSource
        selectThemeController.setUpdateDataSourceClosure { (dataSource) in
            self.updateDataSource(dataSource: dataSource)
        }
        
        self.present(selectThemeController, animated: true) {}
    }
    
    func updateDataSource(dataSource: DataSourceType) {
        self.dataSource = dataSource
        self.menuView.updateDataSource(data: dataSource)
    }
    
    // Mark: - UICollectionViewDataSource
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

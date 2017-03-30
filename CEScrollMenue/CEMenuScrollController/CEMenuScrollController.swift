//
//  CESelectThemeViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit


class CEMenuScrollController: UIViewController, UICollectionViewDataSource {

    var menuView: CEMenuView!
    var contentCollectionView: CEContentCollectionView!
    
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
        self.view.backgroundColor = UIColor.white

        self.addMenuView()
        self.addContentCollectionView()
    }
    
    func addMenuView() {
        self.menuView = CEMenuView(dataSource: self.dataSource, frame: CGRect(x: 0, y: 63, width: SCREEN_WIDTH, height: 30))
        weak var weak_self = self
        self.menuView.setTapSelectThemeClosure {
            weak_self?.presentCESelectThemeController()
        }
        
        ///点击Cell的回调
        self.menuView.setDidSelectItemClosure { (indexPath) in
            print("点击的第\(indexPath.row)个Cell")
            weak_self?.dataSource = DataSourceTools.setSelcted(dataSource: self.dataSource, index: indexPath.row)
            weak_self?.menuView.updateDataSource(data: self.dataSource)
        }
        
        self.view.addSubview(self.menuView)
    }
    
    func addContentCollectionView() {
        let y = self.menuView.frame.origin.y + self.menuView.frame.height
        self.contentCollectionView = CEContentCollectionView(frame: CGRect(x: 0, y: y, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - y), data: self.dataSource[0])
        self.contentCollectionView.dataSource = self
        self.view.addSubview(contentCollectionView)
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
        self.contentCollectionView.reloadData()
    }

    
    // Mark: - UICollectionViewDataSource
    
    // Mark: - UICollectionViewDataSource
    
    ///返回Section的个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///返回每个Section中Item的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.first!.count
    }
    
    ///返回相应的Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return fetchCEThemeCollectionViewCell(indexPath: indexPath)
    }
    
    func fetchCEThemeCollectionViewCell(indexPath: IndexPath ) -> CEContentCollectionViewCell {
        let cell: CEContentCollectionViewCell = self.contentCollectionView.dequeueReusableCell(withReuseIdentifier: CEContentwCellReusableIdentifier, for: indexPath) as! CEContentCollectionViewCell
        
        let item = dataSource[indexPath.section][indexPath.row] as CEThemeDataSourceProtocal
        cell.setContent(text: item.menuItemName())
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

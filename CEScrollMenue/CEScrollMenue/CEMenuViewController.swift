//
//  CESelectThemeViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit


class CEMenuViewController: UIViewController, UICollectionViewDataSource {

    var menueCollectionView: CEMenuCollectionView!
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
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.menueCollectionView = CEMenuCollectionView(frame: CGRect(x: 0, y: 60, width: SCREEN_WIDTH, height: 35),
                                                        data: dataSource[0])
        self.menueCollectionView.dataSource = self
        self.view.addSubview(self.menueCollectionView)
        
        let button = UIButton(frame: CGRect(x: 30, y: 300, width: 60, height: 50))
        button.setTitle("Select", for: .normal)
        button.addTarget(self, action: #selector(showSelectMenu(sender:)), for: .touchUpInside)
        button.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(button)
    }

    func showSelectMenu(sender: UIButton) {
        let selectThemeController = CESelectThemeController(dataSource: self.dataSource)
        
        //获取更新后的DataSource
        selectThemeController.setUpdateDataSourceClosure { (dataSource) in
            DataSourceTools.displayDataSource(dataSource: dataSource)
            self.dataSource = dataSource
            self.menueCollectionView.data = self.dataSource[0]
            self.menueCollectionView.reloadData()
        }
        
        self.present(selectThemeController, animated: true) {}
    }
    
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
    
    func fetchCEThemeCollectionViewCell(indexPath: IndexPath ) -> CEMenuCollectionViewCell {
        let cell: CEMenuCollectionViewCell = self.menueCollectionView.dequeueReusableCell(withReuseIdentifier: MenuCellReuseIdentifier, for: indexPath) as! CEMenuCollectionViewCell
        
        let item = dataSource[indexPath.section][indexPath.row] as CEThemeDataSourceProtocal
        cell.setMenu(text: item.menuItemName())
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

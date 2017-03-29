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
        self.menueCollectionView = CEMenuCollectionView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 150),
                                                        data: dataSource[0])
        self.menueCollectionView.dataSource = self
        self.view.addSubview(self.menueCollectionView)
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

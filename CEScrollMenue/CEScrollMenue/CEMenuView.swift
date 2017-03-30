//
//  CEMenuView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/30.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
typealias TapSelectThemeClosure = () -> Void
class CEMenuView: UIView, UICollectionViewDataSource {
    var menueCollectionView: CEMenuCollectionView!
    var dataSource: DataSourceType!
    var tapSelectThemeClosure: TapSelectThemeClosure!
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    init(dataSource: DataSourceType, frame: CGRect) {
        super.init(frame: frame)
        self.dataSource = dataSource
        self.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.addMenuCollectionView()
        self.addSelectThemeButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMenuCollectionView() {
        self.menueCollectionView = CEMenuCollectionView(frame: getMenueCollectionViewFrame(),
                                                        data: dataSource[0])
        self.menueCollectionView.dataSource = self
        self.addSubview(self.menueCollectionView)
    }
    
    func addSelectThemeButton() {
        let button = UIButton(frame: getSelectButtonFrame())
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.addTarget(self, action: #selector(showSelectMenu(sender:)), for: .touchUpInside)
        self.addSubview(button)
    }

    func setTapSelectThemeClosure(closure: @escaping TapSelectThemeClosure) {
        self.tapSelectThemeClosure = closure
    }
    
    func getMenueCollectionViewFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: SCREEN_WIDTH - height, height: height)
    }

    func getSelectButtonFrame() -> CGRect {
        return CGRect(x: SCREEN_WIDTH - height, y: -2, width: height, height: height)
    }
    
    func updateDataSource(data: DataSourceType) {
        self.dataSource = data
        self.menueCollectionView.data = data[0]
        self.menueCollectionView.reloadData()
    }
    
    func showSelectMenu(sender: UIButton) {
        if self.tapSelectThemeClosure != nil {
            self.tapSelectThemeClosure()
        }
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
}

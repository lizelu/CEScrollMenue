//
//  CESelectThemeViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit


class CEMenuScrollController: UIViewController, UICollectionViewDataSource {

    var menuView: CEMenuView!   //上方滑动的菜单View
    var contentCollectionView: CEContentCollectionView!     //下方滚动的内容Cell
    
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
    
    //Mark: - Private Method
    
    /// 添加菜单View
    private func addMenuView() {
        self.menuView = CEMenuView(dataSource: self.dataSource, frame: CGRect(x: 0, y: 63, width: SCREEN_WIDTH, height: 45))
        weak var weak_self = self
        self.menuView.setTapSelectThemeClosure {
            weak_self?.presentCESelectThemeController()
        }
        
        ///点击每个菜单时的回调
        self.menuView.setDidSelectItemClosure { (indexPath) in
            weak_self?.handelMeneClickEvent(indexPath: indexPath)
        }
        
        self.view.addSubview(self.menuView)
    }
    
    /// 添加下方的内容CollectionView
    private func addContentCollectionView() {
        let y = self.menuView.frame.origin.y + self.menuView.frame.height
        self.contentCollectionView = CEContentCollectionView(frame: CGRect(x: 0, y: y, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - y), data: self.dataSource[0])
        self.contentCollectionView.dataSource = self
        weak var weak_self = self
        self.contentCollectionView.setCurrentShowCellClosure { (currentShowIndexPath) in
            weak_self?.menuView.scrollToItem(indexPath: currentShowIndexPath)
        }
        self.view.addSubview(contentCollectionView)
    }
    
    /// 处理菜单点击的事件
    ///
    /// - Parameter indexPath: 点击的菜单的IndexPath
    private func handelMeneClickEvent(indexPath: IndexPath) {
        dataSource = DataSourceTools.setSelcted(dataSource: self.dataSource, index: indexPath.row)
        menuView.updateDataSource(data: self.dataSource)
        contentCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
    }
    
    /// 模态展示菜单编辑VC
    private func presentCESelectThemeController() {
        let selectThemeController = CESelectThemeController(dataSource: self.dataSource)
        
        //获取更新后的DataSource
        selectThemeController.setUpdateDataSourceClosure { (dataSource) in
            self.updateDataSource(dataSource: dataSource)
            let firstIndexPath = IndexPath(row: 0, section: 0)
            self.menuView.scrollToItem(indexPath: firstIndexPath)
            self.contentCollectionView.scrollToItem(at: firstIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
        self.present(selectThemeController, animated: true) {}
    }
    
    /// 编辑后更新数据源
    ///
    /// - Parameter dataSource: 编辑后的数据源
    private func updateDataSource(dataSource: DataSourceType) {
        self.dataSource = DataSourceTools.setSelcted(dataSource: dataSource, index: 0)
        self.menuView.updateDataSource(data: self.dataSource)
        self.contentCollectionView.reloadData()
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

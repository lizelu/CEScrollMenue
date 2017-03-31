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
    var menueCollectionView: CEMenuCollectionView!      //存放菜单的CollectionView
    var dataSource: DataSourceType!
    var tapSelectThemeClosure: TapSelectThemeClosure!       //点击加号所执行的回调方法，将该事件回调到VC中，由VC显示操作菜单的页面
    var didSelectItmeClosure: CEDidSelectItemClosureType!   //点击菜单的回调
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    //MARK:- Life Cycle
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
    
    //MARK:- Public Method
    
    public func setDidSelectItemClosure(closure: @escaping CEDidSelectItemClosureType) {
        self.didSelectItmeClosure = closure
    }
    
    public func setTapSelectThemeClosure(closure: @escaping TapSelectThemeClosure) {
        self.tapSelectThemeClosure = closure
    }
    
    /// 更新MenuView的数据源
    ///
    /// - Parameter data: 更新后的数据源
    public func updateDataSource(data: DataSourceType) {
        self.dataSource = data
        self.menueCollectionView.data = data[0]
        self.menueCollectionView.reloadData()
    }

    
    /// 当用户移动内容时，将菜单移动到相应位置
    ///
    /// - Parameter indexPath: 当期显示的IndexPath
    public func scrollToItem(indexPath: IndexPath) {
        if self.didSelectItmeClosure != nil {
            self.menueCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            self.didSelectItmeClosure(indexPath)
        }
    }
    
    //MARK:- Private Method
    private func addMenuCollectionView() {
        self.menueCollectionView = CEMenuCollectionView(frame: getMenueCollectionViewFrame(),
                                                        data: dataSource[0])
        self.menueCollectionView.dataSource = self
        weak var weak_self = self
        self.menueCollectionView.setDidSelectItemClosure { (indexPath) in
            if weak_self?.didSelectItmeClosure != nil {
                weak_self?.didSelectItmeClosure(indexPath)
            }
        }
        self.addSubview(self.menueCollectionView)
    }
    
    private func addSelectThemeButton() {
        let button = UIButton(frame: getSelectButtonFrame())
        self.addBackview(button: button)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.addTarget(self, action: #selector(showSelectMenu(sender:)), for: .touchUpInside)
        self.addSubview(button)
    }
    
    ///为按钮添加渐变背景
    private func addBackview(button: UIButton) {
        let color1 = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.85)
        let color2 = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        let colors = [color1.cgColor, color2.cgColor];
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.colors = colors
        gradient.frame = button.bounds
        button.layer.addSublayer(gradient)
    }
    
    private func getMenueCollectionViewFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height)
    }

    private func getSelectButtonFrame() -> CGRect {
        return CGRect(x: SCREEN_WIDTH - height, y: -2, width: height, height: height)
    }
    
    /// 点击加号按钮所执行的方法
    ///
    /// - Parameter sender: 添加按钮对象
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
        cell.isSelected = item.isSelect()
        cell.updateSelectState()
        return cell
    }
}

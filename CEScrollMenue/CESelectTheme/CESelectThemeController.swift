//
//  ViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/24.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SelectThemeBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
typealias DataSourceType = Array<Array<CEThemeDataSourceProtocal>>

typealias UpdataDataSourceClosure = (DataSourceType!) -> Void

class CESelectThemeController: UIViewController, UICollectionViewDataSource{
    
    private var themeCollectionView: CEThemeCollectionView!
    private var dataSource: DataSourceType!
    private var isEdit: Bool = false
    private var dataSourceClosure: UpdataDataSourceClosure!     //更新数据源后要执行的闭包
    
    private var themeCollectionViewWidth: CGFloat {
        get {
            return SCREEN_WIDTH
        }
    }
    
    private var themeCollectionViewHeight: CGFloat {
        get {
            return SCREEN_HEIGHT - 30
        }
    }
    
    //MARK:- Life Cycle
    init(dataSource: DataSourceType) {
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SelectThemeBackgroundColor
        self.addCloseButton()
        self.addThemeCollectionView()
    }
    
    //MARK:- Public Metthod
    public func setUpdateDataSourceClosure(closure: @escaping UpdataDataSourceClosure) {
        self.dataSourceClosure = closure
    }
    
    // MARK: - Event Response
    
    func tapCloseButton(sender: UIButton) {
        if self.dataSourceClosure != nil {
            self.dataSourceClosure(self.dataSource)
        }
        self.dismiss(animated: true) {}
    }
    
    func tapCellButton(cell: CEThemeCollectionViewCell) {
        guard let indexPath = themeCollectionView.indexPath(for: cell) else {
            return
        }
        
        let moveItem = self.dataSource[indexPath.section].remove(at: indexPath.row)
        if indexPath.section == 0 {
            self.dataSource[1].insert(moveItem, at: 0)
        } else {
            self.dataSource[0].append(moveItem)
        }
        self.themeCollectionView.reloadData()
    }
    
    
    //MARK:- Private Method
    
    /// 添加关闭当前页面的Button
    private func addCloseButton() {
        let closeButton = CECloseButton(frame: CGRect(x: SCREEN_WIDTH - 70, y: 30, width: 50, height: 30))
        closeButton.addTarget(self, action: #selector(tapCloseButton(sender:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    ///添加选择主题的View
    private func addThemeCollectionView() {
        self.themeCollectionView = CEThemeCollectionView(frame: CGRect(x: 0, y: 60, width:themeCollectionViewWidth,  height: themeCollectionViewHeight), collectionViewLayout: UICollectionViewFlowLayout())
        self.themeCollectionView.dataSource = self
        self.view.addSubview(self.themeCollectionView)
    }
    
    /// 获取第一个Second的HeaderView
    ///
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - kind: 重用View的种类
    /// - Returns: 返回重用Header
    private func fetchCEFirstHeaderCollectionReusableView(indexPath: IndexPath, kind: String) -> CEHeaderCollectionReusableView {
        let headerView: CEFirstHeaderCollectionReusableView = self.themeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: firstSectionheaderReuseIdentifier, for: indexPath) as! CEFirstHeaderCollectionReusableView
        headerView.selectedEditButton(isSelect: self.isEdit)
        headerView.titleLabel.text = "我的频道"
        weak var weak_self = self
        headerView.setTapEditButtonClosure { (isEdit) in
            weak_self?.isEdit = isEdit
            weak_self?.themeCollectionView.isEnableEdit(isEditor: isEdit)
            weak_self?.themeCollectionView.reloadData()
        }
        
        return headerView
    }
    
    /// 获取第二个Second的HeaderView
    ///
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - kind: kind
    /// - Returns: headerView
    private func fetchCEHeaderCollectionReusableView(indexPath: IndexPath, kind: String) -> CEHeaderCollectionReusableView {
        let headerView: CEHeaderCollectionReusableView = self.themeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! CEHeaderCollectionReusableView
        headerView.titleLabel.text = "推荐频道"
        return headerView
    }
    
    /// 获取Cell对象
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: CEThemeCollectionViewCell
    private func fetchCEThemeCollectionViewCell(indexPath: IndexPath ) -> CEThemeCollectionViewCell {
        let cell: CEThemeCollectionViewCell = self.themeCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CEThemeCollectionViewCell
        
        let item = dataSource[indexPath.section][indexPath.row] as CEThemeDataSourceProtocal
        cell.textLabel.text = item.menuItemName()
        
        if indexPath.section == 0 {
            cell.isHiddenEditImageView(isHidden: !self.isEdit)
            cell.editButton.isEnabled = self.isEdit
        } else {
            cell.isHiddenEditImageView(isHidden: true)
            cell.editButton.isEnabled = true
        }
        
        weak var weak_self = self
        cell.setTapButtonClosure { (currentCell) in
            weak_self?.tapCellButton(cell: currentCell)
        }
        return cell
    }
    
    //更新数据源
    private func updateDataSource(at: IndexPath, to: IndexPath) {
        if at.section == to.section {
            let temp = self.dataSource[at.section][at.row]
            self.dataSource[at.section][at.row] = self.dataSource[to.section][to.row]
            self.dataSource[to.section][to.row] = temp
            return
        }
        let removeItem = self.dataSource[at.section].remove(at: at.row)
        self.dataSource[to.section].insert(removeItem, at: 0)
    }

    //MARK:- UICollectionViewDataSource
    
    ///返回Section的个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    ///返回每个Section中Item的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    ///返回相应的Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return fetchCEThemeCollectionViewCell(indexPath: indexPath)
    }

    ///返回Section的HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            return fetchCEFirstHeaderCollectionReusableView(indexPath: indexPath, kind: kind)
        }
        return fetchCEHeaderCollectionReusableView(indexPath: indexPath, kind: kind)
    }
    
    ///该indexPath所对应的Cell是否可移动
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    ///移动后更新数据源
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.updateDataSource(at: sourceIndexPath, to: destinationIndexPath)
        self.themeCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("CESelectThemeController-deinit")
    }


}


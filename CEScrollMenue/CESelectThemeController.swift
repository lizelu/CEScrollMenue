//
//  ViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/24.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

let reuseIdentifier = "CEThemeCollectionViewCell"
let headerReuseIdentifier = "CEHeaderCollectionReusableView"
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

class CESelectThemeController: UIViewController, UICollectionViewDataSource{
    
    var themeCollectionView: CEThemeCollectionView!
    var dataSource: Array<Array<String>>!
    var isEdit: Bool = false
    
    var themeCollectionViewWidth: CGFloat {
        get {
            return SCREEN_WIDTH
        }
    }
    
    var themeCollectionViewHeight: CGFloat {
        get {
            return SCREEN_HEIGHT - 30
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.dataSource = createDataSource()
        self.addThemeCollectionView()
    }
    
    ///添加选择主题的View
    func addThemeCollectionView() {
        self.themeCollectionView = CEThemeCollectionView(frame: CGRect(x: 0, y: 30, width:themeCollectionViewWidth,  height: themeCollectionViewHeight), collectionViewLayout: UICollectionViewFlowLayout())
        self.themeCollectionView.dataSource = self

        self.view.addSubview(self.themeCollectionView)
    }
    
    
    /// 同一个Section中进行交换
    ///
    /// - Parameters:
    ///   - at: <#at description#>
    ///   - to: <#to description#>
    func swap(at: IndexPath, to: IndexPath) {
        let temp = self.dataSource[at.section][at.row]
        self.dataSource[at.section][at.row] = self.dataSource[to.section][to.row]
        self.dataSource[to.section][to.row] = temp
    }
    
    
    /// 不同的Section中进行更新
    ///
    /// - Parameters:
    ///   - at: <#at description#>
    ///   - to: <#to description#>
    func updateDataSource(at: IndexPath, to: IndexPath) {
        let removeItem = self.dataSource[at.section].remove(at: at.row)
        self.dataSource[to.section].insert(removeItem, at: 0)
    }
    
    func createDataSource() -> Array<Array<String>> {
        var dataSource = Array<Array<String>>()
        for i in 0..<2 {
            var subArray = Array<String>()
            for j in 0..<15 {
                subArray.append("菜单\(i)-\(j)")
            }
            dataSource.append(subArray)
        }
        return dataSource
    }
    
    
    // Mark: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CEThemeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CEThemeCollectionViewCell
        cell.textLabel.text = dataSource[indexPath.section][indexPath.row]
        
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
        
        return cell;
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: CEHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! CEHeaderCollectionReusableView
        headerView.editButton.isSelected = self.isEdit
        if indexPath.section == 0 {
            headerView.titleLabel.text = "我的频道"
            headerView.setHiddenEditeButton(isHidden: false)
        } else {
            headerView.titleLabel.text = "推荐频道"
            headerView.setHiddenEditeButton(isHidden: true)
        }
        
        weak var weak_self = self
        headerView.setTapEditButtonClosure { (isEdit) in
            weak_self?.isEdit = isEdit
            weak_self?.themeCollectionView.isEnableEdit(isEditor: isEdit)
            weak_self?.themeCollectionView.reloadData()
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
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


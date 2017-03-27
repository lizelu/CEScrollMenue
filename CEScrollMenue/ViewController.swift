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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var themeCollectionView: UICollectionView!
    
    var themeCollectionViewWidth: CGFloat {
        get {
            return SCREEN_WIDTH - 60
        }
    }
    
    var themeCollectionViewHeight: CGFloat {
        get {
            return SCREEN_HEIGHT - 60
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addThemeCollectionView()
    }
    
    ///添加选择主题的View
    func addThemeCollectionView() {
        self.themeCollectionView = UICollectionView(frame: CGRect(x: 30, y: 30, width:themeCollectionViewWidth,  height: themeCollectionViewHeight), collectionViewLayout: UICollectionViewFlowLayout())
        self.themeCollectionView.delegate = self
        self.themeCollectionView.dataSource = self
        self.themeCollectionView.isScrollEnabled = true
        self.themeCollectionView.register(CEThemeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
        self.themeCollectionView.register(CEHeaderCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        self.view.addSubview(self.themeCollectionView)
    }
    
    
    
    // Mark: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CEThemeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CEThemeCollectionViewCell
        cell.textLabel.text = "\(indexPath.section)-\(indexPath.row)"
        cell.backgroundColor = UIColor.red
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        return headerView
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 50)
    }
    

    
    // MARK: - UICollectionViewDataSource
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


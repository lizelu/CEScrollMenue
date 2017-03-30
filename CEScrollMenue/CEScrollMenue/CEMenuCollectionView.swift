//
//  CEMenuCollectionView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
let MenuCellReuseIdentifier = "CEMenuCollectionViewCell"
typealias CEDidSelectItemClosureType = (Int) -> ()
class CEMenuCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let minimumLineAndInteritemSpacingForSection: CGFloat = 15
    var data: Array<CEThemeDataSourceProtocal>!
    var didSelectItmeClosure: CEDidSelectItemClosureType!
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    init(frame: CGRect, data: Array<CEThemeDataSourceProtocal>) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        self.configCurrentView()
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDidSelectItemClosure(closure: @escaping CEDidSelectItemClosureType) {
        self.didSelectItmeClosure = closure
    }
    
    func configCurrentView() {
        self.register(CEMenuCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: MenuCellReuseIdentifier)
        self.isScrollEnabled = true
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clear
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        if self.didSelectItmeClosure != nil{
            self.didSelectItmeClosure(indexPath.row)
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:CGFloat(self.data[indexPath.row].itemWidth())  , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
}

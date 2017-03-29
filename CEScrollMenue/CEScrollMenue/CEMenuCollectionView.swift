//
//  CEMenuCollectionView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
let MenuCellReuseIdentifier = "CEMenuCollectionViewCell"
class CEMenuCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let minimumLineAndInteritemSpacingForSection: CGFloat = 10
    var data: Array<CEThemeDataSourceProtocal>!
    
    init(frame: CGRect, data: Array<CEThemeDataSourceProtocal>) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        self.data = data
        self.register(CEMenuCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: MenuCellReuseIdentifier)
        self.backgroundColor = UIColor.gray
        self.isScrollEnabled = true
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(CGFloat(self.data[indexPath.row].itemWidth()))
        return CGSize(width:CGFloat(self.data[indexPath.row].itemWidth())  , height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    

}

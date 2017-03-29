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
    
    let normalCellSize = CGSize(width: 60, height: 40)
    let minimumLineAndInteritemSpacingForSection: CGFloat = 2
    var data: Array<CEThemeDataSourceProtocal>!
    
    init(frame: CGRect, data: Array<CEThemeDataSourceProtocal>) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(CEMenuCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: MenuCellReuseIdentifier)
        self.data = data
        self.backgroundColor = UIColor.gray
        self.isScrollEnabled = true
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.data[indexPath.section].itemWidth())
        return CGSize(width: 60, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }

}

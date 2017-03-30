//
//  CEContentCollectionView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/30.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
let CEContentwCellReusableIdentifier = "CEContentCollectionViewCell"
class CEContentCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let minimumLineAndInteritemSpacingForSection: CGFloat = 0
    var data: Array<CEThemeDataSourceProtocal>!
    
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
 
    func configCurrentView() {
        self.register(CEContentCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: CEContentwCellReusableIdentifier)
        self.isScrollEnabled = true
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clear
        self.isPagingEnabled = true
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

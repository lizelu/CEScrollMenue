//
//  CEMenuCollectionView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
let MenuCellReuseIdentifier = "CEMenuCollectionViewCell"
typealias CEDidSelectItemClosureType = (IndexPath) -> ()
class CEMenuCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let minimumLineAndInteritemSpacingForSection: CGFloat = 15  //菜单的左右边距
    private var data: Array<CEThemeDataSourceProtocal>!
    private var didSelectItmeClosure: CEDidSelectItemClosureType!       //点击菜单Cell要执行的回调
    private var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    //MARK:- Life Cycle
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
    
    //MARK:- Public Method
    public func setDidSelectItemClosure(closure: @escaping CEDidSelectItemClosureType) {
        self.didSelectItmeClosure = closure
    }
    
    public func setDataSource(data: Array<CEThemeDataSourceProtocal>!) {
        self.data = data
    }
    
    //MARK:- Private Method
    private func configCurrentView() {
        self.register(CEMenuCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: MenuCellReuseIdentifier)
        self.isScrollEnabled = true
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clear
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //将点击的Cell移到中点
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
        if self.didSelectItmeClosure != nil{
            self.didSelectItmeClosure(indexPath)
        }
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:CGFloat(self.data[indexPath.row].itemWidth())  , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }


}

//
//  CEThemeCollectionView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/27.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEThemeCollectionView: UICollectionView {
    
    var currentTapIndexPath: IndexPath!
    var targetIndexPath: IndexPath!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.addGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addGestureRecognizer() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPrese(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    func longPrese(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            print("长按开始")
            
            //根据点击的点获取当前的Cell的indexPath
            guard let currentIndexPath = self.indexPathForItem(at: gestureRecognizer.location(in: self)) else {
                return
            }
            print(currentIndexPath)
        }
        
        if gestureRecognizer.state == .ended {
            print("长按结束")
        }
        
    }


}

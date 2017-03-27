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
    var moveView: UIView!
    var moveCell: UICollectionViewCell!
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.addGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addGestureRecognizer() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPrese(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    
    /// 长按手势所触发的方法
    ///
    /// - Parameter gestureRecognizer: <#gestureRecognizer description#>
    func longPrese(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: self)
        
        if gestureRecognizer.state == .began {
            longPressBegin(point: point)
        }
        
        if gestureRecognizer.state == .changed {
            longPressChange(point: point)
        }
    
        if gestureRecognizer.state == .ended {
            longPressEnd()
        }
    }
    
    
    /// 开始长按
    ///
    /// - Parameter point: 长按的开始的点
    func longPressBegin(point: CGPoint) {
        //根据点击的点获取当前的Cell的indexPath
        self.currentTapIndexPath = self.indexPathForItem(at: point)
        if self.currentTapIndexPath == nil {
            return
        }
        print(currentTapIndexPath)
        
        guard let cell = self.cellForItem(at: currentTapIndexPath!) else {
            return
        }
        
        self.moveView = cell.snapshotView(afterScreenUpdates: false)
        self.moveView.center = point
        self.moveView.alpha = 0.8
        self.addSubview(self.moveView)
        UIView.animate(withDuration: 0.7, animations: {
            var frame = self.moveView.frame
            frame.size.width += 10
            frame.size.height += 10
            self.moveView.frame = frame
        })
        
        cell.isHidden = true
        moveCell = cell
    }
    
    
    /// 长按后进行移动
    ///
    /// - Parameter point: 移动时的点
    func longPressChange(point: CGPoint) {
        guard let moveIndexPath = self.indexPathForItem(at: point) else {
            return
        }
        
        if moveIndexPath.section == currentTapIndexPath.section &&
            moveIndexPath.row != currentTapIndexPath.row {
            self.moveItem(at: currentTapIndexPath, to: moveIndexPath)
            self.currentTapIndexPath = moveIndexPath
        }
        self.moveView.center = point
    }
    
    
    /// 长按结束
    func longPressEnd() {
        self.moveView.removeFromSuperview()
        self.moveCell.isHidden = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("move")
    }


}

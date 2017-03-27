//
//  CEThemeCollectionView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/27.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
typealias UpdateDataSourceClosure = (_ at: IndexPath, _ to: IndexPath) -> Void
typealias SwapDataSourceClosure = (_ at: IndexPath, _ to: IndexPath) -> Void
class CEThemeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var currentTapIndexPath: IndexPath!
    var targetIndexPath: IndexPath!
    var moveView: UIView!
    var moveCell: UICollectionViewCell!
    var updateDataSourceClosure: UpdateDataSourceClosure!
    var swapDataSourceClosure: SwapDataSourceClosure!
    var gestureRecognizer: UILongPressGestureRecognizer!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(CEThemeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
        self.register(CEHeaderCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.isScrollEnabled = true
        self.delegate = self
        self.addGestureRecognizer()
        self.isEnableEdit(isEditor: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEnableEdit(isEditor: Bool) {
        self.gestureRecognizer.isEnabled = isEditor
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPrese(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    func setUpdataDataSource(updateDataSourceClosure: @escaping UpdateDataSourceClosure) {
        self.updateDataSourceClosure = updateDataSourceClosure
    }
    
    func setSwapDataSource(swapDataSourceClosure: @escaping SwapDataSourceClosure) {
        self.swapDataSourceClosure = swapDataSourceClosure
    }
    

    
    /// 长按手势所触发的方法
    ///
    /// - Parameter gestureRecognizer: <#gestureRecognizer description#>
    func longPrese(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: self)
        let tapIndexPath = self.indexPathForItem(at: point)
        
        switch gestureRecognizer.state {
        case .began:
            self.currentTapIndexPath = tapIndexPath
            self.beginInteractiveMovementForItem(at: self.currentTapIndexPath)
            
        case .changed:
            self.updateInteractiveMovementTargetPosition(point)
            
        case .ended:
            self.self.endInteractiveMovement()
            
        default:
            self.cancelInteractiveMovement()
        }
        
        return
        
        //只有第一个Second才有长按手势
        if tapIndexPath?.section != 0 {
            return
        }
        
        if gestureRecognizer.state == .began {
            longPressBegin(point: point)
        }
        
        if gestureRecognizer.state == .changed {
            longPressChange(point: point)
        }
    
        if gestureRecognizer.state == .ended {
            longPressEnd(point: point)
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
            
            //更新数据源
            if self.updateDataSourceClosure != nil {
                self.swapDataSourceClosure(currentTapIndexPath, moveIndexPath)
                self.reloadData()
            }
            self.currentTapIndexPath = moveIndexPath
        }
        self.moveView.center = point
        
        print(point)
    }
    
    
    /// 长按结束
    func longPressEnd(point: CGPoint) {
        self.moveView.removeFromSuperview()
        self.moveCell.isHidden = false
        
        guard let moveEndIndexPath = self.indexPathForItem(at: point) else {
            return
        }
        
        //不同的Section
        if moveEndIndexPath.section != currentTapIndexPath.section {
            //更新数据源
            if self.updateDataSourceClosure != nil {
                self.updateDataSourceClosure(currentTapIndexPath, moveEndIndexPath)
            }
        }
        self.reloadData()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 30, 0, 30)
    }

}

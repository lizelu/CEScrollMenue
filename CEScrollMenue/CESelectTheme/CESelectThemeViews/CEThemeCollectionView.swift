//
//  CEThemeCollectionView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/27.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

let reuseIdentifier = "CEThemeCollectionViewCell"
let headerReuseIdentifier = "CEHeaderCollectionReusableView"
let firstSectionheaderReuseIdentifier = "CEFirstHeaderCollectionReusableView"

class CEThemeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var moveCell: UICollectionViewCell!
    var moveView: UIView!
    var gestureRecognizer: UILongPressGestureRecognizer!
    let normalCellSize = CGSize(width: (SCREEN_WIDTH - 45) / 4, height: 40)
    let bigCellSize = CGSize(width: 110, height: 50)
    let minimumLineAndInteritemSpacingForSection: CGFloat = 5
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.config()
        self.addGestureRecognizer()
    }
    
    func config() {
        self.register(CEThemeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
        self.register(CEHeaderCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        self.register(CEFirstHeaderCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: firstSectionheaderReuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.isScrollEnabled = true
        self.delegate = self
    }
    
    /// 设置手势是否可用
    ///
    /// - Parameter isEditor: <#isEditor description#>
    func isEnableEdit(isEditor: Bool) {
        self.gestureRecognizer.isEnabled = isEditor
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPrese(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1
        self.addGestureRecognizer(gestureRecognizer)
        self.isEnableEdit(isEditor: false)
    }
    
    /// 长按手势所触发的方法
    ///
    /// - Parameter gestureRecognizer: <#gestureRecognizer description#>
    func longPrese(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: self)
        
        switch gestureRecognizer.state {
        case .began:
            self.longPressBegin(point: point)
            
        case .changed:
            longPressChange(point: point)
            
        case .ended:
            longPressEnd()
            
        default:
            self.cancelInteractiveMovement()
        }
        
        return
    }
    
    /// 开始长按
    ///
    /// - Parameter point: 长按的开始的点
    func longPressBegin(point: CGPoint) {
        guard let tapIndexPath = self.indexPathForItem(at: point) else {
            return
        }
        
        //只有第一个Section才可以进行拖动排序
        if tapIndexPath.section != 0 {
            return
        }
        
        self.beginInteractiveMovementForItem(at: tapIndexPath)
        
        guard let cell = self.cellForItem(at: tapIndexPath) else {
            return
        }
        cell.isHidden = true
        moveCell = cell
        
        self.moveView = cell.snapshotView(afterScreenUpdates: false)
        self.moveView.center = point
        self.moveView.alpha = 0.8
        self.addSubview(self.moveView)
        UIView.animate(withDuration: 0.7, animations: {
            self.moveView.frame.size = self.bigCellSize
        })
       
    }
    
    /// 长按后进行移动
    ///
    /// - Parameter point: 移动时的点
    func longPressChange(point: CGPoint) {
        if self.moveView != nil {
            self.moveView.center = point
        }
        
        self.updateInteractiveMovementTargetPosition(point)
    }
    
    /// 长按结束
    func longPressEnd() {
        self.endInteractiveMovement()
        if self.moveView != nil {
            self.moveView.removeFromSuperview()
        }
        
        if self.moveCell != nil {
            self.moveCell.isHidden = false
        }
    }

    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    /// 改变Cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.normalCellSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineAndInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("CEThemeCollectionView-deinit")
    }
}

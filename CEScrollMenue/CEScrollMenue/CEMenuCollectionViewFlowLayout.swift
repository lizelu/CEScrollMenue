//
//  CEMenuCollectionViewFlowLayout.swift
//  CEScrollMenue
//
//  Created by lizelu on 2018/5/18.
//  Copyright © 2018年 ZeluLi. All rights reserved.
//

import UIKit

class CEMenuCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var currentSelectIndexPath = IndexPath(row: 0, section: 0)
    
    private var currentAttributesArr = [UICollectionViewLayoutAttributes]()
    private var lastAttributesArr = [UICollectionViewLayoutAttributes]()
    private var attributesArr = [UICollectionViewLayoutAttributes]()
    
    /// 选中的indexPath
    var selectIndexPath: IndexPath {
        get {
            return self.currentSelectIndexPath
        }
        set (indexPath) {
            if indexPath != self.currentSelectIndexPath {
                self.currentSelectIndexPath = indexPath
                self.collectionView?.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    
    // MARK: - must override methods
    override func prepare() {
        super.prepare()
        self.attributesArr = [UICollectionViewLayoutAttributes]()
        if let numOfItems = self.collectionView?.numberOfItems(inSection: 0) {
            for i in 0 ..< numOfItems {
                let indexPath = IndexPath(item: i, section: 0);
                if let attributes = self.layoutAttributesForItem(at: indexPath) {
                    self.attributesArr.append(attributes)
                }
            }
        }
        if self.currentAttributesArr.isEmpty {
            self.currentAttributesArr = self.attributesArr;
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = super.layoutAttributesForItem(at: indexPath)
        var frame = attribute?.frame
        if frame?.origin.y != 0 {
            frame?.origin.y = 15;
        }
        attribute?.frame = frame!;
        return attribute
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attributesArr
    }


    
    // MARK: - option override method
    //    //此方法刷新动画的时候会调用
    //    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
    //        let frame = self.currentFrameWithIndexPath(self.currentSelectIndexPath)
    //        return CGPointMake(frame.centerX-self.collectionView!.width/2.0, 0)
    //    }
    
    // MARK: animation method
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        self.lastAttributesArr = self.currentAttributesArr;
        self.currentAttributesArr = self.attributesArr;
    }
    
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        attributes?.frame = self.lastAttributesArr[itemIndexPath.row].frame
        attributes?.alpha = 1.0
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        //注意，这里alpha设置为不透明，系统默认返回是0，即一个淡出的效果
        attributes?.alpha = 1.0
        attributes?.frame = self.currentAttributesArr[itemIndexPath.row].frame
        return attributes
    }
    
    
    override func finalizeCollectionViewUpdates() {
        
    }

    
}

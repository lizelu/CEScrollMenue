//
//  UIViewConstraintExtension.swift
//  CEScrollMenue
//
//  Created by ZeluLi on 2017/3/25.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
extension UIView {
    func addTopConstraint(value: CGFloat, toItme: UIView?) {
        let topConstraint = NSLayoutConstraint(item: self,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: toItme,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: value)
        self.addConstraint(topConstraint);
    }
    
    func addLeftConstraint(value: CGFloat, toItme: UIView?) {
        let topConstraint = NSLayoutConstraint(item: self,
                                               attribute: .left,
                                               relatedBy: .equal,
                                               toItem: toItme,
                                               attribute: .left,
                                               multiplier: 1,
                                               constant: value)
        self.addConstraint(topConstraint);
    }
    
    func addRightConstraint(value: CGFloat, toItme: UIView?) {
        let topConstraint = NSLayoutConstraint(item: self,
                                               attribute: .right,
                                               relatedBy: .equal,
                                               toItem: toItme,
                                               attribute: .right,
                                               multiplier: 1,
                                               constant: value)
        self.addConstraint(topConstraint);
    }
    
    func addWidthConstraint(value: CGFloat, toItme: UIView?) {
        let topConstraint = NSLayoutConstraint(item: self,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: toItme,
                                               attribute: .right,
                                               multiplier: 1,
                                               constant: value)
        self.addConstraint(topConstraint);
    }



}

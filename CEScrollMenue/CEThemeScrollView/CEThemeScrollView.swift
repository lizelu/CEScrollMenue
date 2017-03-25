//
//  CEThemeScrollView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/24.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEThemeScrollView: UIScrollView {
    
    var haveSelectView: UIView!
    var nonSelectView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        
        self.addSelectView()
        self.addNonSelectView()
    }
    
    func addSelectView() {
        self.haveSelectView = UIView(frame: CGRect.zero)
        self.haveSelectView.backgroundColor = UIColor.gray
        self.addSubview(self.haveSelectView)
        
        self.haveSelectView.translatesAutoresizingMaskIntoConstraints = false
        self.haveSelectView.addTopConstraint(value: 0, toItme: self)
    }
    
    func addNonSelectView() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

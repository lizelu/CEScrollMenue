//
//  SecondHeaderCollectionReusableView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/28.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEHeaderCollectionReusableView: UICollectionReusableView {
    
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTitleLabel()
        self.addDetailLabel()
    }
    
    func addTitleLabel() {
        self.titleLabel = UILabel(frame: CGRect(x: 15, y: 30, width: 85, height: 20))
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(titleLabel)
    }
    
    func addDetailLabel() {
        self.detailLabel = UILabel(frame: CGRect(x: self.titleLabel.frame.width, y: 30, width: 100, height: 20))
        self.detailLabel.font = UIFont.systemFont(ofSize: 11)
        self.detailLabel.textColor = UIColor.lightGray
        self.detailLabel.text = "点击可以添加"
        self.addSubview(detailLabel)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

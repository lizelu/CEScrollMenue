//
//  HeaderCollectionReusableView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/27.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEHeaderCollectionReusableView: UICollectionReusableView {
    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.titleLabel = UILabel(frame: self.bounds)
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

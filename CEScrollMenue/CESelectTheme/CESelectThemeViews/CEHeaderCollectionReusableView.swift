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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTitleLabel()
    }
    
    func addTitleLabel() {
        self.titleLabel = UILabel(frame: CGRect(x: 15, y: 30, width: 85, height: 20))
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

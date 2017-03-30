//
//  MenuCollectionViewCell.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEMenuCollectionViewCell: UICollectionViewCell {
    
    var menuLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        addMenuLabel()
    }
    
    func addMenuLabel() {
        self.menuLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: self.frame.height))
        self.menuLabel.textColor = UIColor.darkGray
        self.menuLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(menuLabel)
    }
    
    func setMenu(text: String) {
        self.menuLabel.text = text
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

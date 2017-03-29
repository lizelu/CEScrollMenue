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
        addMenuLabel()
    }
    
    func addMenuLabel() {
        self.menuLabel = UILabel(frame: self.bounds)
        self.menuLabel.textColor = UIColor.white
        self.menuLabel.font = UIFont.systemFont(ofSize: 15)
        self.menuLabel.textAlignment = .center
        self.addSubview(menuLabel)
    }
    
    func setMenu(text: String) {
        self.menuLabel.text = text
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MenuCollectionViewCell.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/29.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEMenuCollectionViewCell: UICollectionViewCell {
    private var menuLabel: UILabel!     //显示菜单名字的Label
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        addMenuLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 根据数据的状态来设置Cell的选择状态
    public func updateSelectState() {
        if self.isSelected {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.menuLabel.textColor = UIColor.red
            })
        } else {
            self.menuLabel.textColor = UIColor.black
        }
    }
    
    public func setMenu(text: String) {
        self.menuLabel.text = text
    }
    
    private func addMenuLabel() {
        self.menuLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: self.frame.height))
        self.menuLabel.textColor = UIColor.darkText
        self.menuLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(menuLabel)
    }
}

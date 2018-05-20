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
    private var textHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = UIColor.gray
        addMenuLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.menuLabel.frame = CGRect(x: 0, y: self.frame.height - self.textHeight, width: self.frame.width, height: self.textHeight)
    }
    
    /// 根据数据的状态来设置Cell的选择状态
    public func updateSelectState() {
        
       self.textHeight = 16;
        if self.isSelected {
            self.menuLabel.textColor = UIColor.red
            self.textHeight = 22;
        } else {
            self.menuLabel.textColor = UIColor.black
        }
        
    }
    
    public func setMenu(text: String) {
        self.menuLabel.text = text
    }
    
    private func addMenuLabel() {
        self.menuLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height - 16, width: 300, height: 16))
        self.menuLabel.textColor = UIColor.darkText
        self.menuLabel.font = UIFont.systemFont(ofSize: 15)
        self.menuLabel.textAlignment = .center
        self.contentView.addSubview(menuLabel)
    }
}

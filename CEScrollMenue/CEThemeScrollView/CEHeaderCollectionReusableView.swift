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
    var editButton: CEThemeEditButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 30, width: 200, height: 20))
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(titleLabel)
        
        self.editButton = CEThemeEditButton(frame: CGRect(x: self.frame.width - 50, y: 30, width: 40, height: 30))
        self.editButton.addTarget(self, action: #selector(tapEditButton(sender:)), for: .touchUpInside)
        self.addSubview(self.editButton)
        
    }
    
    func tapEditButton(sender: CEThemeEditButton) {
        sender.isSelected = !sender.isSelected
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

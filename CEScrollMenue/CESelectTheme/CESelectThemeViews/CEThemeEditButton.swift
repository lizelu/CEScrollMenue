//
//  CEThemeEditButton.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/27.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEThemeEditButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 10
        self.setTitle("编辑", for: .normal)
        self.setTitle("完成", for: .selected)
        self.setTitleColor(UIColor.red, for: .normal)
        self.isSelected = false
        self.titleLabel?.font = UIFont.systemFont(ofSize: 11)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

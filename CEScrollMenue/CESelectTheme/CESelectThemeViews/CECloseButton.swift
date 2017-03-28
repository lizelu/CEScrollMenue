//
//  CECloseButton.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/28.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CECloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 10
        self.setTitle("关闭", for: .normal)
        self.setTitleColor(UIColor.blue, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

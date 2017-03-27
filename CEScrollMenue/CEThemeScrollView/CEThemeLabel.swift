//
//  CEThemeLabel.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/24.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEThemeLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.white
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

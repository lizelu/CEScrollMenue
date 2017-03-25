//
//  CEThemeView.swift
//  CEScrollMenue
//
//  Created by ZeluLi on 2017/3/25.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEThemeView: UIView {
    
    var themeScrollView: CEThemeScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.addThemeScrollView()
    }
    
    func addThemeScrollView()  {
        self.themeScrollView = CEThemeScrollView(frame: frame)
        self.themeScrollView.contentSize = frame.size
        self.addSubview(themeScrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

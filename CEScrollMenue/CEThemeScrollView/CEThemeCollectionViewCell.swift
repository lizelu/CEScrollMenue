//
//  CEThemeCollectionViewCell.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/27.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEThemeCollectionViewCell: UICollectionViewCell {
    var textLabel: CEThemeLabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        if textLabel == nil {
            textLabel = CEThemeLabel(frame: self.contentView.bounds)
            self.contentView.addSubview(textLabel)
        }
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

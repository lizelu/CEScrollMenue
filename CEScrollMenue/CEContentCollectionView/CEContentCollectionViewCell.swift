//
//  CEContentCollectionViewCell.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/30.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class CEContentCollectionViewCell: UICollectionViewCell {
    var contentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addContentLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setContent(text: String) {
        self.contentLabel.text = text
    }
    
    private func addContentLabel() {
        self.contentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 300))
        self.contentLabel.textColor = UIColor.darkText
        self.contentLabel.adjustsFontSizeToFitWidth = true
        self.contentLabel.font = UIFont.systemFont(ofSize: 70)
        self.contentLabel.layer.shadowOpacity = 0.5
        self.contentLabel.layer.shadowColor = UIColor.black.cgColor
        self.contentLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.contentLabel.textAlignment = .center
        self.contentView.addSubview(contentLabel)
    }

}

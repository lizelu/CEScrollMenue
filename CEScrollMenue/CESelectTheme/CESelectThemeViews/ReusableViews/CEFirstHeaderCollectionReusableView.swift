//
//  HeaderCollectionReusableView.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/27.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit
typealias TapEditButtonClosure = (Bool) -> Void
class CEFirstHeaderCollectionReusableView: CEHeaderCollectionReusableView {
    
    var editButton: CEThemeEditButton!
    var editButtonClosure: TapEditButtonClosure!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addEditButton()
        self.detailLabel.text = "拖动可以排序"
        self.detailLabel.isHidden = true
    }
    
    func setTapEditButtonClosure(editButtonClosure: @escaping TapEditButtonClosure) {
        self.editButtonClosure = editButtonClosure
    }
    
    func setHiddenEditeButton(isHidden: Bool) {
        self.editButton.isHidden = isHidden
    }
    
    func addEditButton() {
        self.editButton = CEThemeEditButton(frame: CGRect(x: self.frame.width - 55, y: 26, width: 40, height: 25))
        self.editButton.addTarget(self, action: #selector(tapEditButton(sender:)), for: .touchUpInside)
        self.addSubview(self.editButton)
    }
    
    func tapEditButton(sender: CEThemeEditButton) {
        editButton.isSelected = !editButton.isSelected
        detailLabel.isHidden = !editButton.isSelected
        print(editButton.isSelected)
        if editButtonClosure != nil {
            self.editButtonClosure(editButton.isSelected)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

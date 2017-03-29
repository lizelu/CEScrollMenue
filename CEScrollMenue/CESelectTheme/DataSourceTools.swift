//
//  Tools.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/28.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class MeteData: CEThemeDataSourceProtocal {
    var name: String = ""
    var width: Float = 30
    init(name: String) {
        self.name = name
        self.width = Float(calculateContentWidth(contentText: self.name))
    }
    
    func menuItemName() -> String {
        return self.name
    }
    
    func itemWidth() -> Float {
       return self.width
    }
    
    func calculateContentWidth(contentText: String) -> CGFloat {
        let maxLabelSize: CGSize = CGSize(width: 1000, height: 0)
        let contentNSString = contentText as NSString
        let rect = contentNSString.boundingRect(with: maxLabelSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13)], context: nil)
        return rect.size.width

    }
}

class DataSourceTools: NSObject {
    class func createDataSource() -> DataSourceType {
        var dataSource = Array<Array<CEThemeDataSourceProtocal>>()
        for i in 0..<2 {
            var subArray = Array<CEThemeDataSourceProtocal>()
            for j in 0..<15 {
                if j % 3 == 0 {
                    subArray.append(MeteData(name: "特选频道\(i)-\(j)"))
                } else {
                    subArray.append(MeteData(name: "频道\(i)-\(j)"))
                }
                
            }
            dataSource.append(subArray)
        }
        return dataSource
    }
    
    class func displayDataSource(dataSource: DataSourceType) {
        for items in dataSource {
            print("======Section=======")
            for item in items {
                print(item.menuItemName())
            }
            print("\n\n")
        }
    }
    
    
}

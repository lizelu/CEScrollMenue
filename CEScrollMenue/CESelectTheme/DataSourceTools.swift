//
//  Tools.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/28.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import Foundation

class MeteData: CEThemeDataSourceProtocal {
    var name: String = ""
    init(name: String) {
        self.name = name
    }
    
    func menuItemName() -> String {
        return self.name
    }
}

class DataSourceTools: NSObject {
    class func createDataSource() -> Array<Array<CEThemeDataSourceProtocal>> {
        var dataSource = Array<Array<CEThemeDataSourceProtocal>>()
        for i in 0..<2 {
            var subArray = Array<CEThemeDataSourceProtocal>()
            for j in 0..<15 {
                subArray.append(MeteData(name: "频道\(i)-\(j)"))
            }
            dataSource.append(subArray)
        }
        return dataSource
    }
    
    class func displayDataSource(dataSource: Array<Array<CEThemeDataSourceProtocal>>) {
        for items in dataSource {
            print("======Section=======")
            for item in items {
                print(item.menuItemName())
            }
            print("\n\n")
        }
    }
    
    
}

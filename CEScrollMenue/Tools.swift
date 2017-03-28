//
//  Tools.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/28.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

class Tools: NSObject {
    class func createDataSource() -> Array<Array<String>> {
        var dataSource = Array<Array<String>>()
        for i in 0..<2 {
            var subArray = Array<String>()
            for j in 0..<15 {
                subArray.append("频道\(i)-\(j)")
            }
            dataSource.append(subArray)
        }
        return dataSource
    }

}

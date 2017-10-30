//
//  Post.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/19.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

struct Post {
    var userId : Int
    var id: Int
    var title : String
    var body : String
    
    init(json: JSON) {
        userId = json["userId"].intValue
        id = json["id"].intValue
        title = json["title"].stringValue
        body = json["body"].stringValue
    }
}



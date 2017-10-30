//
//  Comments.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/30.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comments {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    init(json: JSON) {
        postId = json["postId"].intValue
        id = json["id"].intValue
        name = json["name"].stringValue
        email = json["email"].stringValue
        body = json["body"].stringValue
    }
}

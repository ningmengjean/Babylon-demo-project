//
//  Users.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/29.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Users {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        username = json["username"].stringValue
        email = json["email"].stringValue
        self.address = Address(json: json["address"])
        phone = json["phone"].stringValue
        website = json["website"].stringValue
        self.company = Company(json: json["company"])
    }
}

struct Address {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
    init(json: JSON) {
        street = json["street"].stringValue
        suite = json["suite"].stringValue
        city = json["city"].stringValue
        zipcode = json["zipcode"].stringValue
        self.geo = Geo(json: json["geo"])
    }
}

struct Company {
    var name: String
    var catchPhrase: String
    var bs: String
    init(json: JSON) {
        name = json["name"].stringValue
        catchPhrase = json["cathcPhrase"].stringValue
        bs = json["bs"].stringValue
    }
}

struct Geo {
    var lat: Float
    var lng: Float
    init(json: JSON) {
        lat = json["lat"].floatValue
        lng = json["lng"].floatValue
    }
}















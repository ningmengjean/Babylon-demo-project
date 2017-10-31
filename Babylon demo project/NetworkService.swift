//
//  NetworkService.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/30.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import Foundation
import Moya

enum NetworkService {
    case getTitleFromPost()
}

extension NetworkService: TargetType {
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL {return URL(string:"http://jsonplaceholder.typicode.com")!}
    var path: String {
        switch self {
        case .getTitleFromPost():
            return "/posts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getTitleFromPost():
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .getTitleFromPost():
            return .requestPlain
        }
    }
    var validate: Bool {
        return false
    }
}











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
    case getAutherWithUserId(userId: Int)
    case getCommentsNumWithPostId(id: Int)
}

extension NetworkService: TargetType {
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL {return URL(string:"http://jsonplaceholder.typicode.com")!}
    var path: String {
        switch self {
        case .getTitleFromPost:
            return "/posts"
        case .getAutherWithUserId(let id):
            return "/users/\(id)"
        case .getCommentsNumWithPostId(_):
            return "/comments"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getTitleFromPost,.getAutherWithUserId, .getCommentsNumWithPostId:
            return .get
        }
    }
    var sampleData: Data {
       return Data()
    }
    var task: Task {
        switch self {
        case .getTitleFromPost,.getAutherWithUserId:
            return .requestPlain
        case let .getCommentsNumWithPostId(id: count):
            return .requestParameters(parameters: ["postId": count], encoding: URLEncoding.queryString)
        }
    }
    var validate: Bool {
        return false
    }
}











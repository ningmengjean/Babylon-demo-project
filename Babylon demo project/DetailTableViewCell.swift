//
//  DetailTableViewCell.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/31.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var descriptionBody: UILabel!
    @IBOutlet weak var commentsNum: UILabel!
    
    func configureDetailTableViewCell(_ usersResult: Users, _ post: Post, _ num: Int) {
        auther.text = usersResult.name
        descriptionBody.text = post.body
        commentsNum.text = String(num)
    }
    
    
}

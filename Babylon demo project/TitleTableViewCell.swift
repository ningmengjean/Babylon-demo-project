//
//  TitleTableViewCell.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/30.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var autherNameImage: UIImageView!
    @IBOutlet weak var autherNameLable: UILabel!
    
    func configureTitleTableViewCell(_ postResult: Post) {
       titleLable.text = postResult.title
    }
}

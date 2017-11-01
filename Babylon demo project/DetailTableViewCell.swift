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
    @IBOutlet weak var autherImage: UIImageView!
    func configureDetailTableViewCell(_ usersResult: Users, _ post: Post, _ num: Int) {
        auther.text = usersResult.name
        descriptionBody.text = post.body
        commentsNum.text = String(num)
    }
    
    func organizationPlaceholderImageWithTitle(size: CGSize = CGSize(width: 50, height: 50)) {
        
        guard let firstText = auther.text?.first else {
            return
        }
        let text = String(firstText)
        
        let color = UIColor.blue
        
        let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        containerView.backgroundColor = color
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        containerView.layoutIfNeeded()
        
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: containerView.bounds.size)
            let image =  renderer.image { (_) in
                containerView.layer.render(in: UIGraphicsGetCurrentContext()!)
            }
            autherImage.image = image
        } else {
            UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, false, 0)
            containerView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            autherImage.image = image
        }
    }
}

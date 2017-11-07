//
//  DetailViewController.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/31.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya

class DetailViewController: UIViewController {
    @IBAction func dismissPage(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var detailTableView: UITableView! {
        didSet {
            detailTableView.delegate = self
            detailTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        detailTableView.rowHeight = UITableViewAutomaticDimension
        detailTableView.estimatedRowHeight = 100.0
    }
    
    var post: Post? {
        didSet {
            guard let post = post else {
                return
            }
            getAutherWithUserId(post.userId)
            getCommentsNumWithPostId(post.id)
        }
    }

    var usersResult = [Users]() {
        didSet {
            detailTableView.reloadData()
        }
    }
    
    func parseJSON(_ data: Data) -> JSON {
        return JSON(data: data)
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error with your networking. Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    var result: Users?
    let provider = MoyaProvider<NetworkService>()
    
    func getAutherWithUserId(_ userId: Int) {
        provider.request(.getAutherWithUserId(userId: userId)) { (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
            case .success(let moyaResponse):
                let json = self.parseJSON(moyaResponse.data)
                DispatchQueue.main.async {
                    self.result = Users(json: json)
                    self.usersResult = [self.result!]
                }
            }
        }
    }
    
    var commentsResult: Comments?
    var comments = [Comments]() {
        didSet {
            detailTableView.reloadData()
        }
    }
    
    func getCommentsNumWithPostId(_ id: Int) {
        guard let post = post else {
            return
        }
        provider.request(.getCommentsNumWithPostId(id: post.id)) { (commentsResult) in
            switch commentsResult {
            case .failure(_):
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
            case .success(let moyaResponse):
                DispatchQueue.main.async {
                    self.comments = self.parseJSON(moyaResponse.data).arrayValue.map {
                        Comments(json: $0)
                    }
                }
            }
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        let auther = usersResult[indexPath.row]
        let commentsNum = comments.count
        cell.configureDetailTableViewCell(auther, post!, commentsNum)
        cell.organizationPlaceholderImageWithTitle()
        return cell
    }
}


















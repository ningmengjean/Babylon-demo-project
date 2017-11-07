//
//  TitleViewController.swift
//  Babylon demo project
//
//  Created by wangchi on 2017/10/30.
//  Copyright © 2017年 Zhu xiaojin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya

class TitleViewController: UIViewController {

    @IBOutlet weak var titleTableView: UITableView! {
        didSet {
            titleTableView.delegate = self
            titleTableView.dataSource = self
        }
    }
    
    var postResult = [Post]() {
        didSet {
            titleTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        titleTableView.rowHeight = UITableViewAutomaticDimension
        titleTableView.estimatedRowHeight = 100.0
        getTitleFromPost()
        
    }
    var post: Post?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let post = sender as? Post, segue.identifier == "ToDetail" {
            let nvc = segue.destination as! UINavigationController
            let controller = nvc.visibleViewController as! DetailViewController
            controller.post = post
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
    
    var result: Post?
    let provider = MoyaProvider<NetworkService>()
    func getTitleFromPost() {
        provider.request(.getTitleFromPost()) { (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    self?.showNetworkError()
                }
            case .success(let moyaResponse):
                DispatchQueue.main.async {
                    self.postResult = self.parseJSON(moyaResponse.data).arrayValue.map {Post(json: $0)}
                }
            }
        }
    }
}
extension TitleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
        let postTitle = postResult[indexPath.row]
        cell.configureTitleTableViewCell(postTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postResult[indexPath.row]
        performSegue(withIdentifier: "ToDetail", sender: post)
    }
}

//
//  ViewController.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UITableViewController {
    
    let loader = HomeLoader()
    var users: Results<User>?
    var posts: Results<Post>?
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        title = "Home"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: String(HomeTableViewCell))
        
        users = loader.getCached().0
        posts = loader.getCached().1
        
        if let posts = posts {
            notificationToken = posts.setupNotificationBlock(tableView)
        }
        
        loader.load()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.appDequeueReusableCellForIndexPath(indexPath: indexPath)
        cell.titleLabel.text = posts?[indexPath.row].title
        cell.detailLabel.text = posts?[indexPath.row].body
        cell.accessoryType = .DisclosureIndicator
        return cell
    }

}

//
//  ViewController.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import UIKit
import RealmSwift

class PostViewController: UITableViewController, LoadingViewControllerType {
    
    var screenTitle = "Posts"
    let viewModel = PostViewModel()
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView(frame: CGRectMake(0,0,0,CGFloat.min))
        tableView.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: String(HomeTableViewCell))
        
        notificationToken = viewModel.posts.setupNotificationBlock(self.tableView)
        viewModel.load() { [weak self] in
            self?.setLoading(false)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.loading {
            setLoading(true)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.appDequeueReusableCellForIndexPath(indexPath: indexPath)
        cell.titleLabel.text = viewModel.posts[indexPath.row].title
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = viewModel.posts[indexPath.row]
        let user = self.viewModel.users.filter { $0.id == post.userId }.first
        if let user = user {
            let detailController = PostDetailViewController(post: post, user: user)
            navigationController?.pushViewController(detailController, animated: true)
        } else {
            return
        }
        
    }

}

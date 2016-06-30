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
    var loadingTitle = "Fetching new posts..."
    let viewModel: PostViewModel
    var notificationToken: NotificationToken?
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init(style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView(frame: CGRectMake(0,0,0,CGFloat.min))
        tableView.registerClass(PostTableViewCell.self, forCellReuseIdentifier: String(PostTableViewCell))
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refresh), forControlEvents: .ValueChanged)
        
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
    
    func refresh() {
        if viewModel.loading {
            self.refreshControl?.endRefreshing()
            return
        }
        
        viewModel.load {
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.appDequeueReusableCellForIndexPath(indexPath: indexPath)
        cell.titleLabel.text = viewModel.posts[indexPath.row].title
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = viewModel.posts[indexPath.row]
        let user = self.viewModel.users.filter { $0.id == post.userId }.first
        if let user = user {
            let detailModel = PostDetailViewModel(post: post, user: user)
            let detailController = PostDetailViewController(viewModel: detailModel)
            let loadingController = LoadingViewController(childController: detailController)
            navigationController?.pushViewController(loadingController, animated: true)
        } else {
            return
        }
        
    }

}

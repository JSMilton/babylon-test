//
//  PostDetailViewController.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import UIKit
import PureLayout

class PostDetailViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .Vertical
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkTextColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        return view
    }()
    
    let post: Post
    let user: User
    
    init(post: Post, user: User) {
        self.post = post
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Detail"
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewMarginsExcludingEdge(.Top)
        stackView.autoPinToTopLayoutGuideOfViewController(self, withInset: 20)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(commentsLabel)
        
        NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
            self.titleLabel.autoSetContentHuggingPriorityForAxis(.Vertical)
            self.bodyLabel.autoSetContentHuggingPriorityForAxis(.Vertical)
            self.usernameLabel.autoSetContentHuggingPriorityForAxis(.Vertical)
        }
        
        titleLabel.text = "Title:\n" + post.title
        bodyLabel.text = "Body:\n" + post.body
        usernameLabel.text = "Username:\n" + user.username
    }

}

//
//  PostDetailViewController.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import UIKit
import PureLayout
import RealmSwift

class PostDetailViewController: UIViewController, LoadingViewControllerType {
    
    var screenTitle: String = "Post Detail"
    var loadingTitle = "Loading updated comments..."
    
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
    
    let viewModel: PostDetailViewModel
    var notificationToken: NotificationToken?
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(stackView)
        stackView.autoPinEdgeToSuperviewMargin(.Leading)
        stackView.autoPinEdgeToSuperviewMargin(.Trailing)
        stackView.autoPinToTopLayoutGuideOfViewController(self, withInset: 20)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(commentsLabel)
        
        NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
            self.titleLabel.autoSetContentHuggingPriorityForAxis(.Vertical)
            self.bodyLabel.autoSetContentHuggingPriorityForAxis(.Vertical)
            self.usernameLabel.autoSetContentHuggingPriorityForAxis(.Vertical)
            self.commentsLabel.autoSetContentHuggingPriorityForAxis(.Vertical)
        }
        
        titleLabel.text = "Title:\n" + viewModel.post.title
        bodyLabel.text = "Body:\n" + viewModel.post.body
        usernameLabel.text = "Username:\n" + viewModel.user.username
        
        notificationToken = viewModel.comments?.addNotificationBlock { [weak self] _ in
            self?.updateCommentsLabel()
        }
        
        viewModel.load { [weak self] in
            self?.setLoading(false)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.loading {
            setLoading(true)
        }
    }
    
    func updateCommentsLabel() {
        let filteredComments = viewModel.comments?.filter { $0.postId == viewModel.post.id }
        guard let count = filteredComments?.count else { return }
        commentsLabel.text = "\(count) comments for this post"
    }

}

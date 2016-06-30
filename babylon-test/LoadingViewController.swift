//
//  LoadingViewController.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import UIKit
import PureLayout

protocol LoadingViewControllerType {
    var screenTitle: String { get }
    var loadingTitle: String { get }
    func setLoading(loading: Bool)
}

extension LoadingViewControllerType where Self: UIViewController {
    func setLoading(loading: Bool) {
        guard let parent = parentViewController as? LoadingViewController else { return }
        
        if loading {
            parent.loadingView.activityIndicator.startAnimating()
        } else {
            parent.loadingView.activityIndicator.stopAnimating()
        }
        
        UIView.animateWithDuration(0.25) { 
            parent.loadingView.hidden = !loading
        }
    }
}

class LoadingViewController: UIViewController {
    
    private let childController: LoadingViewControllerType
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .Vertical
        return stackView
    }()
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.clearColor()
        return containerView
    }()
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.hidden = true
        return view
    }()
    
    init (childController: UIViewController) {
        guard let controller = childController as? LoadingViewControllerType else {fatalError("child controller in loading container must conform to LoadingViewControllerType")}
        self.childController = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(stackView)
        stackView.addArrangedSubview(loadingView)
        stackView.addArrangedSubview(containerView)
        stackView.autoPinEdgeToSuperviewEdge(.Leading)
        stackView.autoPinEdgeToSuperviewEdge(.Trailing)
        stackView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        stackView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        containerAddChildViewController(childController as! UIViewController, toView: containerView)
        
        NSLayoutConstraint.autoSetPriority(999) { 
            self.loadingView.autoSetDimension(.Height, toSize: 50)
        }
        
        NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) { () -> Void in
            self.loadingView.autoSetContentHuggingPriorityForAxis(.Vertical)
        }
        
        title = childController.screenTitle
        loadingView.label.text = childController.loadingTitle
    }
}

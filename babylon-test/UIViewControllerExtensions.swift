//
//  ViewControllerExtensions.swift
//  bizzby-bollocks
//
//  Created by James Milton on 04/05/2016.
//  Copyright © 2016 james. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func containerAddChildViewController(viewController:UIViewController, toView:UIView) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
        addChildViewController(viewController)
        viewController.didMoveToParentViewController(self)
        toView.addSubview(viewController.view)
        viewController.view.autoPinEdgesToSuperviewEdges()
    }
    
    func containerRemoveChildViewController(viewController: UIViewController) {
        viewController.willMoveToParentViewController(nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}

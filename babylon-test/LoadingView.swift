//
//  LoadingView.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import UIKit
import PureLayout

class LoadingView: UIView {

    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grayColor()
        label.text = "Loading new data..."
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        addSubview(stackView)
        stackView.autoCenterInSuperview()
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

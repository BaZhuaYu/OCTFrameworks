//
//  OCTActivityIndicator.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/28/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

class OCTActivityIndicatorView: UIView {
    
    static var sharedInstance = OCTActivityIndicatorView()
    
    private var activity: UIActivityIndicatorView!

    private var label: UILabel!
    
    init() {
        super.init(frame: OCTScreen)
        
        self.backgroundColor = AppBackgroundColor.colorWithAlphaComponent(0.3)
        
        activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        
        configLabel()
        configContainer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configContainer() {
        let container = UIView(frame: CGRect(x: OCTScreenWidth/2 - 80, y: OCTScreenHeight/2 - 100, width: 160, height: 100))
        container.backgroundColor = AppBackgroundColor
        container.layer.cornerRadius = 5
        container.clipsToBounds = true
        
        container.addSubview(activity)
        container.addSubview(label)
        
        activity.centerXTo(container)
        activity.centerYTo(container)
        label.centerXTo(container)
        
        self.addSubview(container)
    }
    
    func configLabel() {
        self.label = UILabel(frame: CGRect(x: 0, y: 68, width: 160, height: 32))
        label.textColor = AppForegroundColor
        label.font = UIFont.systemFontOfSize(13)
        label.textAlignment = .Center
    }
    
    
    func start(title: String) {
        activity.startAnimating()
        activity.hidden = false
        self.label.text = title
        UIApplication.sharedApplication().windows.first?.addSubview(self)
    }
    
    func stop() {
        activity.stopAnimating()
        self.removeFromSuperview()
    }
    
    
    
}

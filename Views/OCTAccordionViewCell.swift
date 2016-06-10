//
//  OCTAccordionViewCell.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/11/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

class OCTAccordionViewCell: UIControl {
    var imageView: UIImageView!
    var label: UILabel!
    var accessoryView: UIButton!
    
    let imageViewSize = CGSize(width: 36, height: 36)
    let labelSize = CGSize(width: 200, height: 32)
    let accessoryViewSize = CGSize(width: 40, height: 40)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = AppBackgroundColor.CGColor
        
        
        let offset = 4.0 as CGFloat
        
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: offset, y: self.height/2 - imageViewSize.height/2),
            size: imageViewSize))
        
        label = UILabel(frame: CGRect(origin: CGPoint(x: imageView.right + offset, y: self.height/2 - labelSize.height/2),
            size: labelSize))
        
        label.textColor = UIColor.whiteColor()
        label.font = label.font.fontWithSize(14)
        
        
        accessoryView = UIButton(frame: CGRect(origin: CGPoint(x: self.width - offset - 32, y: self.height/2 - accessoryViewSize.height/2),
            size: accessoryViewSize))
//        accessoryView.backgroundColor = UIColor.redColor()
        
        label.width = self.width - imageView.width - accessoryView.width - offset * 4
    }
    
    
    func config() {

        self.layer.cornerRadius = self.height/2
        self.clipsToBounds = true
        
        self.backgroundColor = AppLightBackgroundColor

        
        self.addSubview(imageView)
        self.addSubview(label)
        self.addSubview(accessoryView)
        
        imageView.centerYTo(self)
        label.centerYTo(self)
        accessoryView.centerYTo(self)
        
        label.x = imageView.right + 4
        label.width = self.width - imageView.width - accessoryView.width - 32
        accessoryView.x = self.width - 4 - accessoryView.width
    }
    
    
    func setAccessaryViewImage(named: String) {
        self.accessoryView.setBackgroundImage(UIImage(named: named), forState: UIControlState.Normal)
//        let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 16, height: 16))
//        imageView.image = UIImage(named: named)
//        accessoryView.addSubview(imageView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}

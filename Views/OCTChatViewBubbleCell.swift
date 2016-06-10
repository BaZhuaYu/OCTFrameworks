//
//  OCTChatViewBubbleCell.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/24/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

enum OCTChatViewBubbleCellLayout {
    case Left
    case Right
}


class OCTChatViewBubbleCell: UITableViewCell {
    var layout = OCTChatViewBubbleCellLayout.Left
    
    private var label: UILabel!
    private var avatar: UIButton!
    
    
    init(layout: OCTChatViewBubbleCellLayout, reuseIdentifier: String?) {
        self.layout = layout
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        
        configBackground()
        configAvatar()
        configLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configBackground() {
        self.size = CGSize(width: OCTScreenWidth, height: 36)
        self.contentView.size = CGSize(width: OCTScreenWidth, height: 36)
        self.selectionStyle = .None
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    private func configAvatar() {
        var x = 0 as CGFloat
        
        switch self.layout {
        case .Left:
            x = 16
        case .Right:
            x = self.contentView.width - 52
        }
        
        avatar = UIButton(frame: CGRect(x: x, y: self.contentView.height/2 - 18, width: 36, height: 36))
        avatar.userInteractionEnabled = false
        avatar.layer.cornerRadius = avatar.width/2
        avatar.clipsToBounds = true
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.lightAqua().CGColor
        
        self.contentView.addSubview(avatar)
        avatar.centerYTo(self.contentView)
    }
    
    
    private func configLabel() {
        label = UILabel(frame: CGRect(x: 60, y: 0, width: self.contentView.width - 120, height: self.contentView.height))
        
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.lightAqua()
        label.lineBreakMode = .ByWordWrapping
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .Center
        
        self.contentView.addSubview(label)
        label.centerYTo(avatar)
    }
    
    
    func setMessage(msg: String, fromUser user: OCTChatUser) {
        avatar.setBackgroundImage(user.avatar, forState: UIControlState.Normal)
        
        let margin = 6 as CGFloat
        
        label.text = msg
        let maxSize = CGSize(width: self.contentView.width, height: 2000)
        let attributes = [NSFontAttributeName: label.font]
        
        let minSize = (NSString(string: msg)).boundingRectWithSize(maxSize, options: [NSStringDrawingOptions.TruncatesLastVisibleLine, NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes: attributes, context: nil).size

        label.width = minSize.width + margin * 2
        label.height = max(self.contentView.height, minSize.height)
        
        switch self.layout {
        case .Right:
            label.x = self.contentView.width - label.width - 52 - 18
            let tri = OCTRightTriangleView(frame: CGRect(x: label.right - 1, y: label.y, width: 10, height: 20))
            tri.backgroundColor = UIColor.clearColor()
            self.contentView.addSubview(tri)
        default:
            label.x = avatar.right + 18
            let tri = OCTLeftTriangleView(frame: CGRect(x: label.x - 8, y: label.y, width: 10, height: 20))
            tri.backgroundColor = UIColor.clearColor()
            self.contentView.addSubview(tri)
        }
        
        avatar.centerYTo(label)
        
    }
    
}


class OCTLeftTriangleView: UIView {
    
    override func drawRect(rect: CGRect) {
        leftTriangle()
    }
    
    func leftTriangle() {
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        CGContextSetLineWidth(context, 1)
        CGContextMoveToPoint(context, 8, 10)
        CGContextAddLineToPoint(context, 0, 15)
        CGContextAddLineToPoint(context, 8, 20)
        CGContextAddLineToPoint(context,8,10)
        CGContextClosePath(context)
        UIColor.lightAqua().setFill()
        UIColor.lightAqua().setStroke()
        
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
    }
    
}


class OCTRightTriangleView: UIView {
    
    override func drawRect(rect: CGRect) {
        rightTriangle()
    }
    
    
    func rightTriangle() {
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        CGContextSetLineWidth(context, 1)
        CGContextMoveToPoint(context, 0, 10)
        CGContextAddLineToPoint(context, 8, 15)
        CGContextAddLineToPoint(context, 0, 20)
        CGContextAddLineToPoint(context,0,10)
        CGContextClosePath(context)
        UIColor.lightAqua().setFill()
        UIColor.lightAqua().setStroke()
        
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
    }
    
}


















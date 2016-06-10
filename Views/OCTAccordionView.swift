//
//  OCTAccordionView.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/10/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

@objc protocol OCTAccordionViewDelegate: NSObjectProtocol {
    optional func accordionView(accordionView: OCTAccordionView, didExpandCell cell: OCTAccordionViewCell)
    optional func accordionView(accordionView: OCTAccordionView, willExpandCell cell: OCTAccordionViewCell)
    optional func accordionView(accordionView: OCTAccordionView, didCollapseCell cell: OCTAccordionViewCell)
    optional func accordionView(accordionView: OCTAccordionView, willCollapseCell cell: OCTAccordionViewCell)
}


@objc protocol OCTAccordionViewDataSource: NSObjectProtocol {
    func numberOfCellsInAccordionView(accordionView: OCTAccordionView) -> Int
    func accordionView(accordionView: OCTAccordionView, cellForIndex index: Int) -> OCTAccordionViewCell
}



class OCTAccordionView: UIView {
    
    var cells = [OCTAccordionViewCell]()
    
    var expandedCellIndex: Int?
    
    let infoView: UIView!
    let infoViewHeight: CGFloat!
    
    weak var delegate: OCTAccordionViewDelegate?
    weak var dataSource: OCTAccordionViewDataSource? {
        didSet{
            reload()
        }
    }
    
    
    var enableExpanding = true
    
    
    let cellHeight = 40 as CGFloat
    
    
    var isAccessoryHidden = false {
        didSet {
            for cell in self.cells {
                cell.accessoryView.hidden = isAccessoryHidden
            }
        }
    }
    
    
    init(frame: CGRect, cellCount: Int, infoView: UIView) {

        self.infoView = infoView
        self.infoViewHeight = infoView.height
        
        super.init(frame: frame)
        

        self.height = cellHeight * CGFloat(cellCount) + CGFloat(4 * (cellCount - 1))
        
        self.backgroundColor = UIColor.clearColor()
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func reload() {

        if let dataSource = self.dataSource {
            for i in 0..<dataSource.numberOfCellsInAccordionView(self) {
                let cell = dataSource.accordionView(self, cellForIndex: i)
                cell.frame = CGRect(x: 0, y: CGFloat(i) * (cellHeight + 4), width: self.width, height: cellHeight)
                cell.config()
                cell.addTarget(self, action: "didClickCell:", forControlEvents: UIControlEvents.TouchUpInside)
                cell.tag = i
                
                self.addSubview(cell)
                cells.append(cell)
            }
        }
        
    }
    
    
    
    //MARK:- Actions
    
    
    func didClickCell(cell: OCTAccordionViewCell) {
        if self.expandedCellIndex == nil {
            expandCell(cell)
        }
        else {
            if self.expandedCellIndex! == cell.tag {
                collapseCell(cell)
            } else {
                collapseThenExpandCell(cell)
                
            }
        }
    }
    
    
    
    //MARK:- Animations
    
    
    
    func expandCell(cell: OCTAccordionViewCell) {
        
        guard enableExpanding else {
            return
        }
        
        
        infoView.height = 0
        self.userInteractionEnabled = false
        self.infoView.frame.origin = CGPoint(x: self.width/2 - infoView.width/2, y: cell.bottom + 2)
        
        UIView.animateWithDuration(0.3, animations: { [unowned self] () -> Void in
            for view in self.cells {
                if view.tag > cell.tag {
                    view.y += self.infoViewHeight
                }
            }
            self.height += self.infoViewHeight
            if let del = self.delegate {
                del.accordionView?(self, willExpandCell: cell)
            }
            

            self.infoView.height = self.infoViewHeight
            self.addSubview(self.infoView)

            
            }) { [unowned self] (Finished) -> Void in
                self.userInteractionEnabled = true
                self.expandedCellIndex = cell.tag
                if let del = self.delegate {
                    del.accordionView?(self, didExpandCell: cell)
                }
        }
    }
    
    
    func collapseCell(cell: OCTAccordionViewCell) {
        infoView.height = self.infoViewHeight
        self.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.3, animations: { [unowned self] () -> Void in
            for view in self.cells {
                if view.tag > cell.tag {
                    view.y -= self.infoViewHeight
                }
            }
            self.height -= self.infoViewHeight
            if let del = self.delegate {
                del.accordionView?(self, willCollapseCell: cell)
            }

            self.infoView.height = 0

            }) { [unowned self] (Finished) -> Void in
                self.userInteractionEnabled = true
                self.expandedCellIndex = nil
                self.infoView.removeFromSuperview()
                if let del = self.delegate {
                    del.accordionView?(self, didCollapseCell: cell)
                }
        }
    }
    
    
    func collapseThenExpandCell(cell: OCTAccordionViewCell) {
        infoView.height = self.infoViewHeight
        self.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.1, animations: { [unowned self] () -> Void in
            for view in self.cells {
                if view.tag > self.cells[self.expandedCellIndex!].tag {
                    view.y -= self.infoViewHeight
                }
            }
            self.height -= self.infoViewHeight
            if let del = self.delegate {
                del.accordionView?(self, willCollapseCell: cell)
            }
            
            self.infoView.height = 0

            }) { [unowned self] (Finished) -> Void in
                self.userInteractionEnabled = true
                self.expandedCellIndex = nil
                self.infoView.removeFromSuperview()
                if let del = self.delegate {
                    del.accordionView?(self, didCollapseCell: cell)
                }
                self.expandCell(cell)
        }
    }
    
    
    
    
    //MARK:- Data Srouce
    
    
    
    
    
    
}

//
//  ChatViewController.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/22/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

enum OCTChatMode {
    case Chat
    case GroupChat
    case ChatRoom
}


struct OCTChatUser {
    var key: String!
    var nickname: String!
    var avatar: UIImage!
}


class OCTChatViewController: UIViewController, UITextFieldDelegate, IChatManagerDelegate, UITableViewDelegate, UITableViewDataSource, OCTTopBarViewDelegate {
    
    var chatTable: UITableView!
    
    var botbar: UIView!
        var textField: UITextField!
    
    
    let myself: OCTChatUser!
    let user: OCTChatUser!
    
    
    var data = [Dictionary<String, AnyObject>]()
    
    
    var tap: UITapGestureRecognizer!
    
    
    init(mode: OCTChatMode, myself: OCTChatUser, user: OCTChatUser) {
        self.myself = myself
        self.user = user
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        self.view = UIView(frame: OCTScreen)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configBackground()
        configTopBar()
        configChatTable()
        configBotBar()
        
        EaseMob.sharedInstance().chatManager.addDelegate(self, delegateQueue: nil)
        

    }
    
    
    deinit {
        Logger.debug("deinit")
    }
    
    
    //MARK:- Configuration
    
    
    private func configBackground() {
        self.view.backgroundColor = AppBackgroundColor
        
        tap = UITapGestureRecognizer(target: self, action: "scrollViewDidScroll:")
        self.view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    private func configTopBar() {
        let topbar = OCTTopBarView(style: TopBarStyle.Dark).configTitleLabel(user.nickname).configLeftButton()
        topbar.delegate = self
        self.view.addSubview(topbar)
    }
    
    
    private func configChatTable() {
        chatTable = UITableView(frame: CGRect(x: 0, y: 64, width: OCTScreenWidth, height: OCTScreenHeight - 64 - 36), style: UITableViewStyle.Plain)

        chatTable.backgroundColor = AppBackgroundColor
        chatTable.tableFooterView = UIView(frame: CGRectZero)
        chatTable.tableHeaderView = UIView(frame: CGRectZero)
        chatTable.separatorStyle = .None
        
        chatTable.delegate = self
        chatTable.dataSource = self
        
        self.view.addSubview(chatTable)
    }
    
    
    private func configBotBar() {
        func configTextField() {
            textField = UITextField(frame: CGRect(x: 36, y: 4, width: OCTScreenWidth - 120, height: 28))
            textField.backgroundColor = UIColor(r: 75, g: 75, b: 75, a: 1)
            textField.layer.cornerRadius = 3
            textField.resignFirstResponder()
            textField.returnKeyType = .Send
            textField.keyboardAppearance = .Dark
            textField.delegate = self
            botbar.addSubview(textField)
        }
        
        
        let size = CGSize(width: OCTScreenWidth, height: 36)
        botbar = UIView(frame: CGRect(x: 0, y: OCTScreenHeight - size.height, width: size.width, height: size.height))
        
        botbar.backgroundColor = AppLightBackgroundColor
        
        configTextField()
        
        
        self.view.addSubview(botbar)
    }
    
    
    
    //MARK:- Actions
    
    
    
    func sendMessage() {
        guard let text = textField.text where !text.isEmpty else {
            return
        }

        let chatText = EMChatText(text: text)
        let body = EMTextMessageBody(chatObject: chatText)
        
        
        let message = EMMessage(receiver: user.key, bodies: [body])
        
        message.messageType = .eMessageTypeChat
        
        let dict = ["user": myself.key, "content": text]
        
        data.append(dict)
        
        EaseMob.sharedInstance().chatManager.sendMessage(message, progress: nil, error: nil)

        
        chatTable.insertRowsAtIndexPaths([NSIndexPath](arrayLiteral: NSIndexPath(forRow: data.count - 1, inSection: 0)), withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    
    
    func didReceiveMessage(message: EMMessage!) {
        let msgBody = message.messageBodies.first as! IEMMessageBody
        
        if msgBody.messageBodyType == .eMessageBodyType_Text {

            let dict = ["user": message.from, "content": msgBody]
            
            data.append(dict as! Dictionary<String, AnyObject>)
            
            chatTable.insertRowsAtIndexPaths([NSIndexPath](arrayLiteral: NSIndexPath(forRow: data.count - 1, inSection: 0)), withRowAnimation: UITableViewRowAnimation.None)
        }
        

    }
    
    
    
    func keyBoardWillShow(note: NSNotification) {

        let userInfo  = note.userInfo// as! Dictionary

        let keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

//        let keyBoardBoundsRect = self.view.convertRect(keyBoardBounds, toView:nil)

//        let keyBaoardViewFrame = textField.frame
        let deltaY = keyBoardBounds.size.height


        let animations:(() -> Void) = {
            self.botbar.transform = CGAffineTransformMakeTranslation(0,-deltaY)
        }
        
        if duration > 0 {
        let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
        
    }
    
    func keyBoardWillHide(note: NSNotification) {
        let userInfo  = note.userInfo
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            self.botbar.transform = CGAffineTransformIdentity
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendMessage()
        textField.text = ""
        return true
    }
    
    
    
}



extension OCTChatViewController {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        var id: String!
        
        if data[row]["user"] as! String == myself.key {
            id = "right"
        } else {
            id = "left"
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? OCTChatViewBubbleCell
        
        if cell == nil {

            if id == "right" {
                cell = OCTChatViewBubbleCell(layout: OCTChatViewBubbleCellLayout.Right, reuseIdentifier: id)
                cell!.setMessage(self.data[row]["content"] as! String, fromUser: myself)
            } else if id == "left" {
                let msgBody = self.data[row]["content"] as! IEMMessageBody
                let chatText = msgBody.chatObject as! EMChatText
                cell = OCTChatViewBubbleCell(layout: OCTChatViewBubbleCellLayout.Left, reuseIdentifier: id)
                cell!.setMessage(chatText.text, fromUser: user)
            }
        }
        

        
        return cell!
    }
}



//
//  ChatVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 22/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var channelNameLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        tableview.delegate = self
        tableview.dataSource = self

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle( _:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
       
       tableview.estimatedRowHeight = 80.0
        tableview.rowHeight = UITableView.automaticDimension
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: DID_CHANGE_USER_DATA, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: DID_CHANGE_USER_DATA, object: nil)
                
            }
        }
        
     
    }
    
    @objc func channelSelected(_ notif: Notification)
    {
        updateWithChannel()
    }
    
    func updateWithChannel()
    {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    @objc func userDataDidChange(_ notif: Notification)
    {
        if AuthService.instance.isLoggedIn
        {
            onLoginGetMessages()
        }
        else
        {
            channelNameLabel.text = "Please Login"
        }
    }
    
    @IBAction func sendMessageBtnPressed(_ sender: Any)
    {
        if AuthService.instance.isLoggedIn
        {
            guard let messageBody = messageTF.text else {return}
            guard let channelID = MessageService.instance.selectedChannel?.id else {return}
            
            SocketService.instance.sendMessage(messageBody: messageBody, userId: UserDataService.instance.id, channelID: channelID) { (success) in
                if(success)
                {
                    self.messageTF.text = ""
                    self.messageTF.resignFirstResponder()
                }
            }
        }
        
    }
    
    @objc func handleTap()
    {
        view.endEditing(true)
    }
    func onLoginGetMessages()
    {
        MessageService.instance.getChannels { (success) in
            if success
            {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }
                else
                {
                    self.channelNameLabel.text = "No Channels yet!"
                }
            }
        }
    }
    
    func getMessages()
    {
        guard let channelID = MessageService.instance.selectedChannel?.id else {return }
        MessageService.instance.getAllMessages(channelID: channelID) { (success) in
            if success {
                print("Successfultt fetched messages")
                self.tableview.reloadData()
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }
        else
        {
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

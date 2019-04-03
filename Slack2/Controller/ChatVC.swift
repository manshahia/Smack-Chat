//
//  ChatVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 22/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var channelNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle( _:)), for: .touchUpInside)
        
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
    
    func onLoginGetMessages()
    {
        MessageService.instance.getChannels { (success) in
            if success
            {
                
            }
        }
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

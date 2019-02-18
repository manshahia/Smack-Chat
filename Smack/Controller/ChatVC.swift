//
//  ChatVC.swift
//  Smack
//
//  Created by Ravi Inder Manshahia on 14/02/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    
    @IBOutlet weak var toggleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        toggleBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }


}

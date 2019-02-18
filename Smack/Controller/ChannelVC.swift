//
//  ChannelVC.swift
//  Smack
//
//  Created by Ravi Inder Manshahia on 14/02/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBAction func unwindToChannelVC(segue : UIStoryboardSegue) {}
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN_VC, sender:self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    

  
}

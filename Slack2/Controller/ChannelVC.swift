//
//  ChannelVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 22/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    @IBAction func loginBtnPressed(_ sender: Any)
    {
        if AuthService.instance.isLoggedIn
        {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }
        else
        {
                performSegue(withIdentifier: TO_LOGIN_SEGUE, sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.didChangeNotification), name: DID_CHANGE_USER_DATA, object: nil)
        
        MessageService.instance.getChannels { (success) in
            
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    @objc func didChangeNotification()
    {
      setupUserInfo()
    }
    
    func setupUserInfo()
    {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
        }
        else
        {
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
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

//
//  ProfileVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 24/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
  
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: AvatarRoundedImgView!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView()
    {
        
        userEmail.text = UserDataService.instance.email
        userName.text = UserDataService.instance.name
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.tapped))
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func tapped()
    {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: DID_CHANGE_USER_DATA, object: nil)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

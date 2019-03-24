//
//  AccountVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 22/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var avatarName = "userDefault"
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        
        guard let name = usernameTF.text, name != "" else {return}
        guard let email = emailTF.text, email != "" else {return}
        guard let password = passwordTF.text, password != "" else { return }
        
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("Registered user")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.addUser(avatarName: "ava", avatarColor: "avaColor", email: email, name: name, completion: { (success) in
                            if success {
                                print("User Created")
                                print(UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL_VC, sender: nil)

                            }
                        })
                    }
                })

            }
            else
            {
                print("failed to register user")
            }
        }
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL_VC, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
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
    @IBAction func chooseAvatarBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: AVATAR_PICKER_SEGUE, sender: nil)
    }
    
}

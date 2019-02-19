//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Ravi Inder Manshahia on 18/02/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //OUtlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userIMG: UIImageView!
    
    //Actions
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNELVC, sender: nil)
    }
    @IBAction func chooseAvatar(_ sender: UIButton) {
    }
    @IBAction func changeBGColor(_ sender: UIButton) {
    }
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        if let email = emailTF.text,
               emailTF.text != "",
           let password = passwordTF.text,
               passwordTF.text != ""
        {
//            print("Email \(email) & Password \(password)")
            AuthService.instance.registerUser(email: email, password: password) { (success) in
                if success
                {
                    AuthService.instance.loginUser(email: email, password: password, completion: { (response) in
                        
                        if response
                        {
                            print("User logged in successfully")
                            print(AuthService.instance.token)
                            print(AuthService.instance.userEmail)
                        }
                        else
                        {
                            print("Login NOT Success")
                        }
                        
                    })
                }
                else
                {
                    print("Account could not be created")
                }
            }
        }
        else
        {
            return
        }
        
    }
    
    //View Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var avatarName = "userDefault"
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = usernameTF.text, name != "" else {return}
        guard let email = emailTF.text, email != "" else {return}
        guard let password = passwordTF.text, password != "" else { return }
        
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("Registered user")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.addUser(avatarName: UserDataService.instance.avatarName, avatarColor: "avaColor", email: email, name: name, completion: { (success) in
                            if success {
                                print("User Created")
                                print(UserDataService.instance.avatarName)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL_VC, sender: nil)
                                NotificationCenter.default.post(name: DID_CHANGE_USER_DATA, object: nil)

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
        setupView()
    }
    
    func setupView()
    {
        
        spinner.isHidden = true
        
        emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceholder])
        usernameTF.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceholder])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceholder])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.tappedGesture))
        
        self.view.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc func tappedGesture()
    {
        self.view.endEditing(true)
    }
    
    @IBAction func changeBackColor(_ sender: Any) {
        
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        
        let randomColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        UIView.animate(withDuration: 2.0) {
            self.userImage.backgroundColor = randomColor

        }
        
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

//
//  LoginVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 22/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let userName = usernameTF.text, userName != "" else { return }
        guard let password = passwordTF.text, password != "" else { return }
        AuthService.instance.loginUser(email: userName, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: DID_CHANGE_USER_DATA, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                        }
                })
            }
        }
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT_SEGUE, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView()
    {
        passwordTF.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.backgroundColor : purplePlaceholder ])
        usernameTF.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.backgroundColor : purplePlaceholder])
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

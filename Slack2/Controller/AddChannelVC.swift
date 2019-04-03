//
//  AddChannelVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 03/04/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var bgView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
            bgView.addGestureRecognizer(tap)
        }
    }
    
    @objc func tapGestureAction()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBAction func createChannelBtnPressed(_ sender: Any) {
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

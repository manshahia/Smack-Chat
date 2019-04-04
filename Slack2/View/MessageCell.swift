//
//  MessageCell.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 04/04/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var avvatarImageView: AvatarRoundedImgView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message : Message)
    {
        userName.text = message.userName
        timeLbl.text = message.timeStamp
        messageLbl.text = message.messageBody
        avvatarImageView.image = UIImage(named: message.userAvatar)
    }

}

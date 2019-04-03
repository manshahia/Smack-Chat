//
//  ChannelCell.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 03/04/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected
        {
            self.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        }
        else
        {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        // Configure the view for the selected state
    }
    
    func configureCell(channel : Channel)
    {
        let title = channel.name ?? ""
        channelLabel.text = "#\(title)"
    }

}

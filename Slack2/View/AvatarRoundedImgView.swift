//
//  AvatarRoundedImgView.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 24/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class AvatarRoundedImgView: UIImageView {

    
    override func awakeFromNib()
    {
        setupView()
    }
    
    func setupView()
    {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

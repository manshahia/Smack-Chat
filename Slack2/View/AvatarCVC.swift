//
//  AvatarCVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 23/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit
enum AvatarType {
    case dark
    case light
}
class AvatarCVC: UICollectionViewCell {
    
   
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func configureCell(index: Int, type: AvatarType)
    {
        if type == AvatarType.dark {
            imageView.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.darkGray.cgColor
        }
        else
        {
            imageView.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
    func setupCell()
    {
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        self.clipsToBounds = true
    }
}

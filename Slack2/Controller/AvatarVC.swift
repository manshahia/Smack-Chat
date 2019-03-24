//
//  AvatarVC.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 23/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit

class AvatarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var avatarType = AvatarType.dark
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark
        {
            UserDataService.instance.setAvatarName(name: "dark\(indexPath.item)")
        }
        else
        {
            UserDataService.instance.setAvatarName(name: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCVC
        {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCVC()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColumns = 4
        }
        
        let sidePadding : CGFloat = 40
        let cellSpacing : CGFloat = 10
        
        let dimension = ((collectionView.bounds.width - sidePadding) - (numberOfColumns - 1) * cellSpacing) / numberOfColumns
        return CGSize(width: dimension, height: dimension)
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var darkLightSegment: UISegmentedControl!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentControlChanged(_ sender: Any) {
        if darkLightSegment.selectedSegmentIndex == 0 {
            avatarType = .dark
        }
        else
        {
            avatarType = .light
        }
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        self.collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

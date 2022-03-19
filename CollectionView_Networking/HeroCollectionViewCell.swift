//
//  HeroCollectionViewCell.swift
//  CollectionView_Networking
//
//  Created by Emre Dogan on 18/03/2022.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    func setup(with hero: Hero) {
        let urlString = "https://api.opendota.com"+hero.img
        print("URLLL ", urlString)
        let url = URL(string: urlString)!
        heroImage.downloaded(from: url)
        heroName.text = hero.localized_name
    }
    
}

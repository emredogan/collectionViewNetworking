//
//  ViewController.swift
//  CollectionView_Networking
//
//  Created by Emre Dogan on 18/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let networkingClient: NetworkingClient = NetworkingClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        networkingClient.downloadJson {
            self.collectionView.reloadData()
        }
        
    }
    
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkingClient.heroes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        cell.setup(with: networkingClient.heroes[indexPath.row])
        return cell
    }
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 100)
    }
}


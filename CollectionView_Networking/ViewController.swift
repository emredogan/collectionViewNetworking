//
//  ViewController.swift
//  CollectionView_Networking
//
//  Created by Emre Dogan on 18/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var heroes = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        downloadJson {
            print("SUCCESS", self.heroes)
            self.collectionView.reloadData()
        }
        
    }
    
    func downloadJson(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { data, url, error in
            if (error == nil) {
                do {
                     self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                } catch  {
                    print("ERROR ", error)
                }
                
            }
        }.resume()
        
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        cell.setup(with: heroes[indexPath.row])
        return cell
    }

    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 100)
    }
}


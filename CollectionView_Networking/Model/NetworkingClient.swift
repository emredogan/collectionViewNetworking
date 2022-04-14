//
//  NetworkingClient.swift
//  CollectionView_Networking
//
//  Created by Emre Dogan on 13/04/2022.
//

import Foundation

class NetworkingClient {
    var heroes = [Hero]()

    // Give a completion handler to this, so when you are done with downloading the data we call that funciton
    func downloadJson(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { [weak self] data, url, error in
            if (error == nil) {
                do {
                    self?.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                    // Since we will relod the collection view here, we need to run it in the main thread, otherwise we will get an error of:
                    // UICollectionView.reloadData() must be used from main thread only
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

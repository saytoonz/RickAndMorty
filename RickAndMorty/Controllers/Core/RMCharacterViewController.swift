//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Sam on 02/02/2023.
//

import UIKit

/// Controller to show and shearch for Characters
final class RMCharacterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
      
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self, completion: { result in
            
            switch result {
            case .success(let model):
                print("Total: " + String(model.info.count))
                print("Total results: " + String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
            
        })
    }
    
}

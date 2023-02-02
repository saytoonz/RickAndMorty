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
        
        let request = RMRequest(
            endPoint: RMEndpoint.character,
        
            queryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value:"alive")
            ]
        )
        
        print(request.url ?? "Hey")
        
        RMService.shared.execute(request, expecting: RMCharacter.self, completion: { result in
            
//            switch result {
//                case .success(<#T##RMCharacter#>)
//            }
        })
    }
    
}

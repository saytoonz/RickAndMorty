//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Sam on 03/02/2023.
//

import Foundation

struct CharacterListViewViewModel {
    func fetchCharacters(){
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

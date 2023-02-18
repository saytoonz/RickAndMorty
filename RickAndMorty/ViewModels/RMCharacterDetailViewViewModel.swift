//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sam on 16/02/2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character : RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    private var requestUrl:URL? {
        return URL(string: character.url)
    }
    
    public var title: String{
        return character.name.uppercased()
    }
    
//    func fetchCharactersData(){
//
//        guard let url = requestUrl,
//              let request = RMRequest(url: url)else{
//             return
//        }
//
//        RMService.shared.execute(
//            request,
//            expecting: RMCharacter.self){ result in
//                switch result {
//                case .success(let data):
//                    print(String(describing: data))
//                    character = data
//                case .failure(let error):
//                    print(String(describing: error))
//                }
//
//            }
//    }
}

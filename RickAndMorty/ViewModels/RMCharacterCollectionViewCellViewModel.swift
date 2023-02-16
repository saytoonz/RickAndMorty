//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sam on 16/02/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
public let characterName: String
private let characterStatus: RMCharacterStatus
private let characterImageUrl: URL?
    
//    MARK: - init
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    
    public var characterStatusText : String  {
        return "Status: \(characterStatus.text)"
    }
    
    
    public func fetchImage(completion: @escaping (Result<Data, Error>)->Void){
        //TODO: Extract to image manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){ data, _ , error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
            
        }
        
        task.resume()
    }
}

//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sam on 16/02/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel : Hashable, Equatable{
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
        
        RMImageLoader.share.downloadImage(url, completion: completion)
    }
    
    
    // MARK: - hashable and equatable
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}

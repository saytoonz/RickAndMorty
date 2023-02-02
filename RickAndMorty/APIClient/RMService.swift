//
//  RMService.swift
//  RickAndMorty
//
//  Created by Sam on 02/02/2023.
//

import Foundation

/// Primarry API service object  to get Rich and Morty data
final class RMService{
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Private construnctor
    private init(){}
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Requeest instance
    ///   - type: The type of object we expect to get back (Here it's made generic )
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
            
        }
    
   
    
    
}
 

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
    ///   - conpletion: Callback with data or error
    public func execute(_ request: RMRequest, conpletion: @escaping () -> Void){
        
    }
    
    
}

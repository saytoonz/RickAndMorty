//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Sam on 02/02/2023.
//

import Foundation

/// Represent unique API endpoint
@frozen enum RMEndpoint: String {
    /// Endpoint to get character info  --- "character"
    case character
    
    /// Endpoint to get location info  --- "character"
    case location
    
    /// Endpoint to get episode info  --- "character"
    case episode
}

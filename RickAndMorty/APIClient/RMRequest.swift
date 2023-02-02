//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sam on 02/02/2023.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    private let endPoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    
    public init(endPoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    
    /// Constructed url for the api request in a string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
            
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
            
        return string
    }
    
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
}

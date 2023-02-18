//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sam on 02/02/2023.
//

import Foundation


/// Object that represents a single API call
final class RMRequest {
    /// Desired endpoints
    private let endPoint: RMEndpoint
    
    /// Path components for API if any
    private let pathComponents: [String]
    
    /// Query parameters for API if any
    private let queryParameters: [URLQueryItem]
    
    /// Construct Requiest
    /// - Parameters:
    ///   - endPoint:  Target Endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query paramenter
    public init(endPoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacing( Constants.baseUrl+"/", with:"")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            
            if !components.isEmpty {
                let endpointString = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndpoint)
                    return
                }
            }
            
        }else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            
            if !components.isEmpty , components.count >= 2{
                let endpointString = components[0]
                let queryItemStrings = components[1]
                let queryItem :[URLQueryItem] = queryItemStrings.components(separatedBy: "&").compactMap({
                    guard $0.contains("=")  else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndpoint, queryParameters: queryItem)
                    return
                }
            }
            
        }
        
        return nil
    }
    
    /// API Constant
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
    
    
    ///  Desired HTTP Method
    public let httpMethod = "GET"
    
    /// Computed and constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endPoint: .character)
}

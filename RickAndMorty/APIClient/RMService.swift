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
    
    
    enum RMServiceError : Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
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
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest){ data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToCreateRequest))
                return
            }
            
            // Decode response
            do {
                let result  = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
            
        }
    
    
    // MARK: - Private
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url =  rmRequest.url else { return nil }
        
        var request  = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        
        return request
    }
    
    
}
 

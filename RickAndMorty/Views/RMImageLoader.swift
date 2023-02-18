//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Sam on 18/02/2023.
//

import Foundation

final class RMImageLoader {
    static let share = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init(){}
    
    /// Get image content with url
    /// - Parameters:
    ///   - url: source url
    ///   - completion: Callback
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>)-> Void) {
        
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key){
            completion(.success(data as Data)) //NSData == Data && NSString == String
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){[weak self] data, _ , error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(data))
            
        }
        
        task.resume()
    }
}

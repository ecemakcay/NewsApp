//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Ecem Akçay on 13.09.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

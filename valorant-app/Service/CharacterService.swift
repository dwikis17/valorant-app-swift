//
//  CharacterService.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 29/10/23.
//

import Foundation

enum CharacterServiceError: Error {
    case serverError(String = "Server error")
}

class CharacterService {
    
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Character], Error>) -> Void) {
        
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, resp , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                completion(.failure(CharacterServiceError.serverError()))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let characterData = try decoder.decode(characterArray.self, from: data).data
                    completion(.success(characterData))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(CharacterServiceError.serverError()))
            }
        }.resume()
    }
    
}

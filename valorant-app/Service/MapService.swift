//
//  MapService.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 16/11/23.
//

import Foundation

enum MapServiceError: Error {
    case serverError(String = "Server error")
}

class MapService {
    static func fetchMaps(with endpoint: Endpoint, completion: @escaping (Result<[Map], Error>) -> Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, resp , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                completion(.failure(MapServiceError.serverError()))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let mapData = try decoder.decode(mapArray.self, from: data).data
                    completion(.success(mapData))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MapServiceError.serverError()))
            }
        }.resume()
    }
    
}

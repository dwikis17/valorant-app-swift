//
//  Endpoint.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 29/10/23.
//

import Foundation

enum Endpoint {
    
    case fetchCharacter(url: String = "/v1/agents")
    case fetchmap(url: String = "/v1/maps")
    
        var request: URLRequest? {
            guard let url = self.url else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = self.httpMethod
            request.httpBody = self.httpBody
            request.addValue(for: self)
            return request
        }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseUrl
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCharacter(let url):
            return url
            
        case .fetchmap(let url):
            return url
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchCharacter:
            return HTTP.Method.get.rawValue
            
        case .fetchmap:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchCharacter:
            return nil
            
        case .fetchmap:
            return nil
        }
    }
    
    private var queryItems: [URLQueryItem]?  {
        switch self {
        case .fetchCharacter:
            return [
                URLQueryItem(name: "isPlayableCharacter", value: "true")
            ]
            
        case .fetchmap:
            return []
        }
    }
    

}

extension URLRequest {
    mutating func addValue (for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCharacter:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            
        case .fetchmap:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
    }
}

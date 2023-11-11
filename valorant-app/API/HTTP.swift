//
//  HTTP.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 29/10/23.
//

import Foundation

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers  {
        
        enum Key: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}

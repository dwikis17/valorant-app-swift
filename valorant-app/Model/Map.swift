//
//  Map.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 16/11/23.
//

import Foundation


struct mapArray: Codable {
    let data: [Map]
}

struct Map: Codable {
    let displayName: String
    let splash: URL?
}

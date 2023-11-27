//
//  File.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 29/10/23.
//

import Foundation


struct characterArray: Codable {
    let data: [Character]
}

struct Character: Codable {
    let displayName: String
    let displayIconSmall: URL?
    let fullPortrait: URL?
    let description: String
    let abilities: [ability]
    let role: role
}

struct role: Codable {
    let displayName: String
    let displayIcon: URL?
}


struct ability: Codable {
    let displayName: String
    let description: String
    let displayIcon: URL?
}


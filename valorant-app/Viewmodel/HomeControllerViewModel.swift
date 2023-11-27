//
//  HomeControllerViewModel.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 31/10/23.
//

import Foundation

class HomeControllerViewModel {
    var onCharacterUpdated: (() -> Void)?
    
    var onError: ((CharacterServiceError) -> Void)?
    
    var onMapUpdated: (() -> Void)?
    
    private(set) var characters: [Character] = [] {
        didSet {
            self.onCharacterUpdated?()
        }
    }
    
    private(set) var maps: [Map] = [] {
        didSet {
            self.onMapUpdated?()
        }
    }
    
    init() {
        self.fetchCharacter()
        self.fetchMap()
    }
    
    public func fetchCharacter() {
        let endpoint = Endpoint.fetchCharacter()
        
        CharacterService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func fetchMap() {
        let endpoint = Endpoint.fetchmap()
        
        MapService.fetchMaps(with: endpoint) { [weak self] result in
            switch result {
            case .success(let map):
                self?.maps = map
                
            case.failure(let error):
                print(error)
            }
        }
        
        
        
    }
}

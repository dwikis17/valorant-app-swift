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
    
    private(set) var characters: [Character] = [] {
        didSet {
            self.onCharacterUpdated?()
        }
    }
    
    init() {
        self.fetchCharacter()
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
}

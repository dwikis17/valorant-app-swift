//
//  CharacterSkillCellCollectionViewCell.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 07/11/23.
//

import UIKit

class CharacterSkillCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterSkillCell"
    
    private(set) var ability:ability!
    
    private let abilityImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.backgroundColor = .systemCyan
        return iv
    }()
    
    
    public func configure(with ability: ability) {
        self.ability = ability
        print("hehe")
        
        
        if let url = self.ability.displayIcon {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data , let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        print(url)
                        self?.abilityImage.image = image
                    }
                }
                
            }.resume()
        }
        self.setupUI()
    }
    
    private func setupUI() {
        self.addSubview(abilityImage)
        abilityImage.layer.cornerRadius = 20
        abilityImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            
            abilityImage.topAnchor.constraint(equalTo: self.topAnchor),
            abilityImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            abilityImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            abilityImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),

        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.abilityImage.image = nil
    }

}

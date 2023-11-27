//
//  CharactersCollectionCell.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 29/10/23.
//

import UIKit

class CharactersCollectionCell: UICollectionViewCell {
    static let identifier = "CharacterCell"
    
    private(set) var character: Character!
    
    private let characterImageView: UIImageView = {
        let iv = CircularImage()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark")
        
        iv.layer.masksToBounds = true
        iv.layer.borderWidth = 1
        iv.backgroundColor = .lightGray
        iv.tintColor = .white
        return iv
    }()
    
    private let characterRole: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "title"
        return label
    }()
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "title"
        return label
    }()
    
    private let rectangleView = RectangleCardView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), backgroundColor: .systemBlue)
    
    public func configure(with character: Character) {
        self.character = character
        if let url = self.character.displayIconSmall{
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data , let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.characterLabel.text = character.displayName
                        self?.characterImageView.image = image
                        self?.characterRole.text = character.role.displayName
                    }
                }
                
            }.resume()
        }
        self.setupUI()
    }
    
    private func setupUI() {
    
        self.addSubview(rectangleView)
        
        self.rectangleView.addSubview(characterRole)
        self.rectangleView.addSubview(characterImageView)
        self.rectangleView.addSubview(characterLabel)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        characterRole.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: self.topAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rectangleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rectangleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            characterImageView.widthAnchor.constraint(equalTo: self.rectangleView.widthAnchor, multiplier: 0.65),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),
            characterImageView.topAnchor.constraint(equalTo: self.rectangleView.topAnchor, constant: 5),
            characterImageView.centerXAnchor.constraint(equalTo: self.rectangleView.centerXAnchor),
            
            characterRole.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10),
            characterRole.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            
            characterLabel.topAnchor.constraint(equalTo: characterRole.bottomAnchor, constant: 15),
            characterLabel.centerXAnchor.constraint(equalTo: characterRole.centerXAnchor),
            
            
        ])
    }
    
    
    override func prepareForReuse() {

        super.prepareForReuse()
        characterImageView.image = nil

    }
}



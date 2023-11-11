//
//  DetailViewController.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 01/11/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let Identifier = "DetailCharacter"
    
    private(set) var character:Character!

   
    private let characterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "..."
        return label
    }()
    
    private let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.text = "title"
        return label
    }()
    
    private let characterRoleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .systemBlue
        return iv
    }()
    
    private let characterDescription: UILabel = {
        let textField = UILabel()
        textField.textColor = .label
        textField.numberOfLines = 0
        textField.textAlignment = .justified
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.text = "characterDescription"
        return textField
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CharacterSkillCellCollectionViewCell.self, forCellWithReuseIdentifier: CharacterSkillCellCollectionViewCell.identifier)
        return cv
    }()
    
    
    init(character: Character!) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.setupUI()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupUI() {
        self.view.addSubview(characterLabel)
        self.view.addSubview(characterImageView)
        self.view.addSubview(characterDescription)
        self.view.addSubview(collectionView)

        
        
        if let url = self.character.fullPortrait{
            URLSession.shared.dataTask(with: url ) {
                (data, response, error) in
                
                if let data = data , let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.characterImageView.image = image
                    }
                }
            }.resume()
        }
        
        
        if let url = self.character.role.displayIcon {
            URLSession.shared.dataTask(with: url) {
                (data, response, error ) in
            
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.characterRoleImageView.image = image
                        self?.roleLabel.text = self?.character.role.displayName
                    }
                }
            }.resume()
        }
    
    
        
        characterDescription.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
 
        DispatchQueue.main.async { [weak self] in
            self?.characterLabel.text = self?.character.displayName
            self?.characterDescription.text = self?.character.description
        }
        
        NSLayoutConstraint.activate([
            characterLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            characterLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
       
            
            characterImageView.topAnchor.constraint(equalTo: self.characterLabel.bottomAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            characterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            characterDescription.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: 20),
            characterDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            characterDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            characterDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),

            
            collectionView.topAnchor.constraint(equalTo: self.characterDescription.bottomAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
    

        ])
    }
    

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.character.abilities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterSkillCellCollectionViewCell.identifier, for: indexPath) as? CharacterSkillCellCollectionViewCell else {
            fatalError("failed to dequeues")
        }
        
        cell.configure(with: self.character.abilities[indexPath.row])
        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    

    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75 )
    }

}


//
//  HomeControllerWithCardViewController.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 10/11/23.
//

import UIKit

class HomeControllerWithCardViewController: UIViewController {
    
    private let cardView = RectangleCardView()
    
    private let viewModel: HomeControllerViewModel
    
    private let characterTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 52, weight: .light)
        label.text = "Agents"
        return label
    }()
    
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CharactersCollectionCell.self, forCellWithReuseIdentifier: CharactersCollectionCell.identifier)
        return cv
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.backgroundColor = .systemBackground
        self.setupUI()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupUI() {
        self.view.addSubview(cardView)
       
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.populateCharacter()
        
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 0),
            cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            cardView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func populateCharacter() {
        self.cardView.addSubview(characterTitleLabel)
        self.cardView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        characterTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.characterTitleLabel.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 20),
            self.characterTitleLabel.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor,constant: 20),
            
            self.collectionView.topAnchor.constraint(equalTo: characterTitleLabel.bottomAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 15),
            self.collectionView.trailingAnchor
                .constraint(equalTo: self.cardView.trailingAnchor, constant: -15),
        ])
    }
}

extension HomeControllerWithCardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionCell.identifier, for: indexPath) as? CharactersCollectionCell else {
            fatalError("failed to dequeue")
        }
        
        cell.configure(with: self.viewModel.characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(character: self.viewModel.characters[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension HomeControllerWithCardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.cardView.frame.width / 2) - 10
        return CGSize(width: size, height: size + 30 )
    }

}

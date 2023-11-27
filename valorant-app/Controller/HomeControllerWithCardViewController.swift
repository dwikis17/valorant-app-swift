//
//  HomeControllerWithCardViewController.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 10/11/23.
//

import UIKit

class HomeControllerWithCardViewController: UIViewController {
    
    private let cardView = RectangleCardView()
    
    private var viewModel: HomeControllerViewModel
    
    private let scrollView: UIScrollView = {
       let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {
       let cv = UIView()
        
        return cv
    }()
    
    private let characterTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 52, weight: .light)
        label.text = "Agents"
        return label
    }()
    
    private let mapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 52, weight: .light)
        label.text = "Map"
        return label
    }()
    
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CharactersCollectionCell.self, forCellWithReuseIdentifier: CharactersCollectionCell.identifier)
        return cv
    }()
    
    private let mapsCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MapsCollectionCellCollectionViewCell.self, forCellWithReuseIdentifier: MapsCollectionCellCollectionViewCell.identifier)
        return cv
    }()
    
    private let mapContainerView = RectangleCardView()
    private let refreshControll = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        refreshControll.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControll.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.addSubview(refreshControll)
        self.charactersCollectionView.delegate = self
        self.charactersCollectionView.dataSource = self
        
        self.mapsCollectionView.delegate = self
        self.mapsCollectionView.dataSource = self
        
        self.setupUI()
    }
    
    @objc private func refresh(refreshControll: UIRefreshControl)  {
        self.viewModel =  HomeControllerViewModel()
        self.setupUI()
        refreshControll.endRefreshing()
        print("gg")
        
    }
    
    private func setupUI() {
        self.contentView.addSubview(cardView)
        self.contentView.addSubview(mapContainerView)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.scrollView.addSubview(contentView)
        self.view.addSubview(scrollView)
        
        contentView.backgroundColor = .white
        self.view.backgroundColor = .white
        scrollView.delegate = self

        cardView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        mapContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            cardView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            cardView.heightAnchor.constraint(equalToConstant: 350),
            
            mapContainerView.topAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: 10),
            
            mapContainerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            mapContainerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            mapContainerView.heightAnchor.constraint(equalToConstant: 350),
            mapContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            
        ])
        
        self.populateCharacter()
        self.populateMap()
    }
    
    private func populateMap() {
        self.mapContainerView.addSubview(mapLabel)
        self.mapContainerView.addSubview(mapsCollectionView)
        
        mapLabel.translatesAutoresizingMaskIntoConstraints = false
        mapsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mapLabel.topAnchor.constraint(equalTo: self.mapContainerView.topAnchor, constant: 20),
            self.mapLabel.leadingAnchor.constraint(equalTo: self.mapContainerView.leadingAnchor, constant: 20),
            
            self.mapsCollectionView.topAnchor.constraint(equalTo: mapLabel.bottomAnchor),
            self.mapsCollectionView.bottomAnchor.constraint(equalTo: self.mapContainerView.bottomAnchor),
            self.mapsCollectionView.leadingAnchor.constraint(equalTo: self.mapContainerView.leadingAnchor, constant: 15),
            self.mapsCollectionView.trailingAnchor
                .constraint(equalTo: self.mapContainerView.trailingAnchor, constant: -15),
        ])
    }
    
    private func populateCharacter() {
        self.cardView.addSubview(characterTitleLabel)
        self.cardView.addSubview(charactersCollectionView)
        
        charactersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        charactersCollectionView.backgroundColor = .white
        characterTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.characterTitleLabel.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 20),
            self.characterTitleLabel.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor,constant: 20),
            
            self.charactersCollectionView.topAnchor.constraint(equalTo: characterTitleLabel.bottomAnchor),
            self.charactersCollectionView.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor),
            self.charactersCollectionView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 15),
            self.charactersCollectionView.trailingAnchor
                .constraint(equalTo: self.cardView.trailingAnchor, constant: -15),
        ])
    }
}

extension HomeControllerWithCardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.charactersCollectionView {
            return self.viewModel.characters.count
        } else {
            return self.viewModel.maps.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.charactersCollectionView {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionCell.identifier, for: indexPath) as? CharactersCollectionCell else {
                        fatalError("failed to dequeue")
                    }
                    
                    cell.configure(with: self.viewModel.characters[indexPath.row])
                    return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapsCollectionCellCollectionViewCell.identifier, for: indexPath) as? MapsCollectionCellCollectionViewCell else {
                fatalError("failed to dequeue")
            }
            
            cell.configure(with: self.viewModel.maps[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == charactersCollectionView.self {
            let vc = DetailViewController(character: self.viewModel.characters[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension HomeControllerWithCardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.cardView.frame.width / 2) - 10
        return CGSize(width: size, height: size + 30 )
    }

}

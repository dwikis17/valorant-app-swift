//
//  MapsCollectionCellCollectionViewCell.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 25/11/23.
//

import UIKit

class MapsCollectionCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "MapCell"
    
    private(set) var map: Map!
    
    private let mapImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .white
        return iv
    }()
    
    private let mapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "title"
        return label
    }()
    
    private let rectangleView = RectangleCardView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), backgroundColor: .systemBlue)
    
    public func configure(with map: Map) {
        self.map = map
        if let url = self.map.splash{
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data , let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.mapLabel.text = map.displayName
                        self?.mapImageView.image = image
                    }
                }
                
            }.resume()
        }
        self.setupUI()
    }
    
    private func setupUI() {
        self.addSubview(rectangleView)
        
  
        self.rectangleView.addSubview(mapImageView)
        self.rectangleView.addSubview(mapLabel)
        
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        mapImageView.translatesAutoresizingMaskIntoConstraints = false
        mapLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: self.topAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rectangleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rectangleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mapImageView.topAnchor.constraint(equalTo: self.rectangleView.topAnchor),
            mapImageView.bottomAnchor.constraint(equalTo: self.rectangleView.bottomAnchor),
            mapImageView.trailingAnchor.constraint(equalTo: self.rectangleView.trailingAnchor),
            mapImageView.leadingAnchor.constraint(equalTo: self.rectangleView.leadingAnchor),
        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
       mapImageView.image = nil

    }
}

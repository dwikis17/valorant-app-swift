//
//  RectangleCardView.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 10/11/23.
//

import UIKit

class RectangleCardView: UIView {
    private var cardBackgroundColor: UIColor = UIColor.white // Default background color

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardView()
    }
    
    init(frame: CGRect, backgroundColor: UIColor) {
        super.init(frame: frame)
        self.cardBackgroundColor = backgroundColor
        setupCardView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCardView()
    }
    
    func setupCardView() {
        self.backgroundColor = cardBackgroundColor
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }
}


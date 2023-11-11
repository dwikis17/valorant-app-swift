//
//  CircularImage.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 11/11/23.
//

import UIKit

class CircularImage: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyCircularMask()
    }

    func applyCircularMask() {
         let radius: CGFloat = self.bounds.size.width / 2.0
         self.layer.cornerRadius = radius
         self.clipsToBounds = true
     }
}

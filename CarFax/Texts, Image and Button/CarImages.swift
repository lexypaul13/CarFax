//
//  CarImages.swift
//  CarFax
//
//  Created by Alex Paul on 7/22/21.
//

import UIKit

class CarImages: UIImageView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    

    
}

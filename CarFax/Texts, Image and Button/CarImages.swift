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
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    func downloadImage(_ url:String)  {
        NetworkManger.sharedTask.downloadImage(from:url){ [weak self] image in
               guard let self = self else { return }
               DispatchQueue.main.async { self.image = image}
        }
    }
    
}

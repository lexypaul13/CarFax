//
//  CFImageViewController.swift
//  CarFax
//
//  Created by Alex Paul on 7/26/21.
//

import UIKit

class CFImageViewController: UIViewController {
    var carImage = CarImages(frame: .zero)
    var carsImages:String?
    
    init(carsImages:String) {
        self.carsImages = carsImages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    private func configure(){
        view.addSubview(carImage)
        
        NSLayoutConstraint.activate([
            carImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            carImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            carImage.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: 0),
            carImage.heightAnchor.constraint(equalToConstant: 600),
            carImage.widthAnchor.constraint(equalToConstant: 600),


        ])
        
        
    }
    
}

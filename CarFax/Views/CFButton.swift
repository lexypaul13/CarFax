//
//  CFButton.swift
//  CarFax
//
//  Created by Alex Paul on 7/22/21.
//

import UIKit

class CFButton: UIButton {

    
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title:String){
        self.init(frame:.zero)
        self.setTitle(title, for: .normal)
    }
    
    private func configure(){
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textColor = .blue
    }
    
    func set(buttontColor: UIColor, title: String) {
        setTitle(title, for: .normal)
    }
    
    
}

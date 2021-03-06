//
//  CFTableViewCell.swift
//  CarFax
//
//  Created by Alex Paul on 7/24/21.
//

import UIKit

class CFTableViewCell: UITableViewCell {
    
    static let resuseIdentifier = "carCell"
    
    let carImage = CFImages(frame: .zero)
    let yearLabel = CFTitleLabel(textAlignment: .left, fontSize: 18, fontStyle: .bold, color: .black)
    let makeLabel =  CFTitleLabel(textAlignment: .left, fontSize: 18, fontStyle: .bold, color: .black)
    let modelLabel =  CFTitleLabel(textAlignment: .left, fontSize: 18, fontStyle: .bold, color: .black)
    let trimLabel =  CFTitleLabel(textAlignment: .left, fontSize: 18, fontStyle: .bold, color: .black)
    let priceLabel = CFTitleLabel(textAlignment: .left, fontSize: 14, fontStyle: .semibold, color: .systemGreen)
    let milageLabel = CFTitleLabel(textAlignment: .left, fontSize: 14, fontStyle: .light, color: .black)
    let locationLabel = CFTitleLabel(textAlignment: .left, fontSize: 14, fontStyle: .medium, color: .black)
    let stateLabel = CFTitleLabel(textAlignment: .left, fontSize: 14, fontStyle: .medium, color: .black)
    let phoneButton = CFButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setCell(carFax:Listing){
        carImage.downloadImage(carFax.images.firstPhoto.small)
        yearLabel.text = String(carFax.year)
        makeLabel.text = carFax.make
        priceLabel.text = String("$\(carFax.currentPrice)")
        modelLabel.text = carFax.model
        trimLabel.text = carFax.trim
        milageLabel.text = String("\(carFax.mileage)k mi")
        locationLabel.text = carFax.dealer.address
        stateLabel.text = carFax.dealer.state
        phoneButton.setTitleColor(.systemBlue, for: .normal)
        phoneButton.contentHorizontalAlignment = .leading
        phoneButton.setTitle(carFax.dealer.phone.toPhoneNumber(), for: .normal)
        phoneButton.isEnabled = true
    
    }
    
   
    private func configure(){
        addSubview(carImage)
        addSubview(yearLabel)
        addSubview(makeLabel)
        addSubview(modelLabel)
        addSubview(trimLabel)
        addSubview(priceLabel)
        addSubview(milageLabel)
        addSubview(locationLabel)
        addSubview(stateLabel)
        contentView.addSubview(phoneButton)
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            carImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            carImage.widthAnchor.constraint(equalToConstant: 150),
            carImage.topAnchor.constraint(equalTo: self.topAnchor),
            carImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

            yearLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            yearLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            
            modelLabel.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor, constant: 5),
            modelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            
            makeLabel.leadingAnchor.constraint(equalTo: modelLabel.trailingAnchor),
            makeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            
            trimLabel.topAnchor.constraint(equalTo: self.makeLabel.bottomAnchor, constant: 2),
            trimLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            trimLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: self.trimLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            milageLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 2),
            milageLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            milageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            locationLabel.topAnchor.constraint(equalTo: self.milageLabel.bottomAnchor, constant: 2),
            locationLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            stateLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 2),
            stateLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            stateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            phoneButton.topAnchor.constraint(equalTo: self.stateLabel.bottomAnchor, constant: 2),
            phoneButton.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            phoneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
    
        ])
    }
    
}

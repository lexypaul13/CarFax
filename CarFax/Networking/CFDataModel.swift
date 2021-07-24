//
//  CFDataModel.swift
//  CarFax
//
//  Created by Alex Paul on 7/22/21.
//

import Foundation

struct CFDataModel: Codable {
    
    let listings: [Listing]
    
    enum CodingKeys: String, CodingKey {
        case listings
    }
}

struct Listing: Codable {
    
    let dealer: Dealer
    let id: String
    let images: Images
    let make: String
    let mileage: Int
    let transmission: Transmission
    let year: Int
    let listPrice: Int
    let trim: String
    let model: String
    
    enum CodingKeys: String, CodingKey {
        case dealer
        case id
        case images
        case make
        case model
        case listPrice
        case mileage
        case transmission
        case year
        case trim
    }
}


struct Dealer: Codable {
    
    let address: String
    let city: String
    let phone: String
    let state: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case phone
        case state
    }
}



// MARK: - Images
struct Images: Codable {
    
    let large, medium, small: [String]
    
    enum CodingKeys: String, CodingKey {
        case large, medium, small
    }
}


enum Transmission: String, Codable {
    case automatic = "Automatic"
    case manual = "Manual"
}



